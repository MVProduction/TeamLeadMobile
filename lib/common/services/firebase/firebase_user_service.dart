import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team_lead/common/services/contracts/auth_user_data.dart';
import 'package:team_lead/common/services/contracts/service_anonymous_user_data.dart';
import 'package:team_lead/common/services/contracts/service_base_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/user_service.dart';
import 'package:http/http.dart' as http;

/// Сервис пользователя на основе Firebase
class FirebaseUserService extends UserService {
  /// Для аутентификации через FireBase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Для аутентификации через гугл
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Вошедший пользователь
  ServiceBaseUserData _loginUser;

  @override
  ServiceBaseUserData getLoginUser() {
    return _loginUser;
  }

  @override
  Future<ServiceUserData> getUserInfoById(String id) async {
    final userData =
        await Firestore.instance.collection('users').document(id).get();

    if (!userData.exists) {
      return null;
    }

    return ServiceUserData(id, userData.data["name"], userData.data["contacts"],
        userData.data["skills"], userData["photoUrl"]);
  }

  /// Авторизируется через google
  @override
  Future<AuthUserData> loginGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    return AuthUserData(user.uid, user.displayName, user.email, user.photoUrl);
  }

  /// Авторизируется через github
  @override
  Future<AuthUserData> loginGithub(String code) async {
    final response = await http.post(
      "https://github.com/login/oauth/access_token",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      body: {
        "client_id": UserService.GithubClientId,
        "client_secret": UserService.GithubClientSecret,
        "code": code
      },
    );

    final jsonResponse = json.decode(response.body);
    final accessToken = jsonResponse["access_token"];

    final credential = GithubAuthProvider.getCredential(
      token: accessToken,
    );

    final userResponse =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userResponse.user;

    return AuthUserData(user.uid, user.displayName, user.email, user.photoUrl);
  }

  /// Сохраняет пользователя
  @override
  Future updateUser(
      String photoUrl, String name, String contacts, String skills) async {
    final id = (getLoginUser() as ServiceUserData).id;

    await Firestore.instance.collection('users').document(id).updateData({
      'name': name,
      'contacts': contacts,
      'skills': skills,
      'photoUrl': photoUrl
    });

    _loginUser = ServiceUserData(id, name, contacts, skills, photoUrl);
  }

  /// Создаёт пользователя
  @override
  Future<ServiceUserData> createUser(String id, String photoUrl, String name,
      String contacts, String skills) async {
    await Firestore.instance.collection('users').document(id).setData({
      'name': name,
      'contacts': contacts,
      'skills': skills,
      'photoUrl': photoUrl
    });

    return ServiceUserData(id, name, contacts, skills, photoUrl);
  }

  /// Подключается к приложению
  @override
  Future<ServiceUserData> login(String id) async {
    _loginUser = await getUserInfoById(id);
    return _loginUser;
  }

  /// Анонимный вход
  @override
  Future<ServiceAnonymousUserData> anonymousLogin() async {
    _loginUser = ServiceAnonymousUserData();
    return _loginUser;
  }
}

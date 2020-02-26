import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:team_lead/common/services/contracts/auth_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Реальный сервис пользователя
class RealUserService extends UserService {
  /// Для аутентификации через FireBase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Для аутентификации через гугл
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  ServiceUserData getLoginUser() {
    return null;
  }

  @override
  Future<ServiceUserData> getUserInfoById(String id) async {
    return null;
  }

  @override
  Future<ServiceUserData> getUserInfoByName(String userName) async {
    return null;
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

  /// Сохраняет пользователя
  @override
  Future saveUser(String name, String contact, String skill) async {
    final id = getLoginUser().id;

    await Firestore.instance
        .collection('users')
        .document()
        .setData({'id': id, 'name': name, 'contact': contact, 'skill': skill});
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/team_lead_app_font.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Страница с логином
class LoginPage extends StatefulWidget {
  /// Конструктор
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

/// Состояние страницы
class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Подключается с помощью google
  void _signWithGoogle() async {
    print(1);
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    print(googleUser.displayName);
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    print(3);
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print(4);
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    print(5);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    print(6);
    final FirebaseUser currentUser = await _auth.currentUser();
    print(currentUser.displayName);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                height: 500,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Icon(Icons.phone_android, size: 136),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 36),
                      child: Text("Войти",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(
                      height: 48,
                      child: RaisedButton.icon(
                          icon: Icon(TeamLeadAppFont.google),
                          color: Colors.red,
                          label: Text("Подключиться через google"),
                          onPressed: _signWithGoogle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: SizedBox(
                        height: 48,
                        child: RaisedButton.icon(
                            icon: Icon(TeamLeadAppFont.github_circled),
                            color: Colors.blue,
                            label: Text("Подключиться через github"),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.PostList);
                            }),
                      ),
                    ),
                  ],
                ))));
  }
}

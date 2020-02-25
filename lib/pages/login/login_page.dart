import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
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
  /// Подключается с помощью google
  void _signWithGoogle() async {
    final googleUser = await teamLeadService.userService.loginGoogle();
    final user =
        await teamLeadService.userService.getUserInfoById(googleUser.id);
    if (user == null) {
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.CreateUser);
    } else {
      Navigator.pop(context);
      Navigator.pushNamed(context, Routes.PostList);
    }
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

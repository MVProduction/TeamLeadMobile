import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:team_lead/pages/post_list/models/posts_model.dart';
import 'package:team_lead/pages/post_list/widgets/post_list_widget.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/team_lead_app_font.dart';

/// Страница с логином
class LoginPage extends StatefulWidget {
  /// Конструктор
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

/// Состояние страницы
class _LoginPageState extends State<LoginPage> {
  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (ctx) => PostsModel())],
        child: Scaffold(
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
                            onPressed: () {
                              Navigator.popAndPushNamed(
                                  context, Routes.PostList);
                            }),
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
                                Navigator.popAndPushNamed(
                                    context, Routes.PostList);
                              }),
                        ),
                      ),
                    ],
                  ))),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/pages/login/login_page.dart';
import 'package:team_lead/pages/post_list/post_list_page.dart';
import 'package:team_lead/routes.dart';

/// Основной класс приложения
class TeamLeadApp extends StatelessWidget {
  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Собери команду',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: PostListPage(),
      initialRoute: Routes.Login,
      routes: {
        Routes.Login: (_) => LoginPage(),
        Routes.PostList: (_) => PostListPage(),
      },
    );
  }
}

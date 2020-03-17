import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_lead/pages/login/stores/login_page_state_type.dart';
import 'package:team_lead/pages/login/stores/login_page_store.dart';
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
  /// Состояние
  final _pageState = LoginPageStore();

  /// Обрабатывает исключения
  void _processException(Exception e) {
    if (e is PlatformException) {
      if (e.code == "ERROR_NETWORK_REQUEST_FAILED") {
        _pageState.state = LoginPageStateType.Error;
        _pageState.errorString = "Отсутствует связь с интернетом";
      } else {
        _pageState.state = LoginPageStateType.Error;
        _pageState.errorString = "Неизвестная ошибка";
      }
    } else {
      _pageState.state = LoginPageStateType.Error;
      _pageState.errorString = "Неизвестная ошибка";
    }
  }

  /// Подключается с помощью google
  void _signWithGoogle() async {
    try {
      await _pageState.loginGoogle(context);
    } catch (e) {
      _processException(e);
    }
  }

  /// Анонимынй вход
  void _anonymousLogin() async {
    try {
      await _pageState.anonymousLogin(context);
    } catch (e) {
      _processException(e);
    }
  }

  /// Попробовать ещё раз после ошибки
  void _tryAgain() {
    _pageState.state = LoginPageStateType.Input;
  }

  /// Инициализирует состояние
  @override
  void initState() {
    super.initState();
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      switch (_pageState.state) {
        case LoginPageStateType.Input:
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
                            padding: const EdgeInsets.only(bottom: 56),
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
                              child: RaisedButton(
                                  color: Colors.blue,
                                  child: Text("Мне только посмотреть"),
                                  onPressed: _anonymousLogin),
                            ),
                          ),
                        ],
                      ))));
        case LoginPageStateType.LoginProcess:
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        case LoginPageStateType.Error:
          return Scaffold(
              body: Center(
            child: Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.error, size: 56),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_pageState.errorString),
                  ),
                  RaisedButton(
                      child: Text("Попробовать ещё"), onPressed: _tryAgain)
                ],
              ),
            ),
          ));
      }

      return Row();
    });
  }
}

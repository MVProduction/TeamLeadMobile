import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/contracts/auth_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/services/user_service.dart';
import 'package:team_lead/pages/login/stores/login_page_state_type.dart';
import 'package:team_lead/routes.dart';
import 'package:url_launcher/url_launcher.dart';

part 'login_page_store.g.dart';

class LoginPageStore = _LoginPageStore with _$LoginPageStore;

/// Модель окна входа
abstract class _LoginPageStore with Store {
  /// Состояние страницы
  @observable
  LoginPageStateType state = LoginPageStateType.Input;

  /// Создаёт пользователя или подключается
  Future _createOrLogin(BuildContext context, AuthUserData authUser) async {
    final user = await teamLeadService.userService.getUserInfoById(authUser.id);
    if (user == null) {
      Navigator.popAndPushNamed(context, Routes.CreateUser,
          arguments: authUser);
    } else {
      await teamLeadService.userService.login(user.id);
      Navigator.popAndPushNamed(context, Routes.PostList);
    }
  }

  /// Проводит подключение через google
  @action
  Future loginGoogle(BuildContext context) async {
    state = LoginPageStateType.Login;
    final googleUser = await teamLeadService.userService.loginGoogle();
    await _createOrLogin(context, googleUser);
  }

  /// Проводит подключение через github
  @action
  Future startLoginGithub() async {
    state = LoginPageStateType.Login;

    const String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        UserService.GithubClientId +
        "&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false        
      );
    } else {
      print("CANNOT LAUNCH THIS URL!");
    }
  }

  /// Завершает подключение к github
  Future endLoginGithub(BuildContext context, String code) async {
    final githubUser = await teamLeadService.userService.loginGithub(code);
    await _createOrLogin(context, githubUser);
  }
}

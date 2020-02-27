import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/login/stores/login_page_state_type.dart';
import 'package:team_lead/routes.dart';

part 'login_page_store.g.dart';

class LoginPageStore = _LoginPageStore with _$LoginPageStore;

/// Модель окна входа
abstract class _LoginPageStore with Store {
  /// Состояние страницы
  @observable
  LoginPageStateType state = LoginPageStateType.Input;

  /// Проводит подключение через
  @action
  Future loginGoogle(BuildContext context) async {
    state = LoginPageStateType.Login;
    final googleUser = await teamLeadService.userService.loginGoogle();
    final user =
        await teamLeadService.userService.getUserInfoById(googleUser.id);
    if (user == null) {
      Navigator.popAndPushNamed(context, Routes.CreateUser,
          arguments: googleUser);
    } else {
      await teamLeadService.userService.login(user.id);
      Navigator.popAndPushNamed(context, Routes.PostList);
    }
  }
}

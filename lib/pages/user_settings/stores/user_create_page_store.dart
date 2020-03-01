import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_page_state_type.dart';
import 'package:team_lead/routes.dart';

part 'user_create_page_store.g.dart';

class UserCreatePageStore = _UserCreatePageStore with _$UserCreatePageStore;

/// Состояние страницы создания пользователя
abstract class _UserCreatePageStore with Store {
  /// Состояние страницы
  @observable
  UserEditPageStateType state = UserEditPageStateType.Edit;

  /// Сохраняет пользователя
  @action
  Future createUser(
      String id, String name, String contacts, String skills, BuildContext context) async {
    state = UserEditPageStateType.Saving;
    
    final user = await teamLeadService.userService
        .createUser(id, name, contacts, skills);

    await teamLeadService.userService.login(user.id);
    Navigator.popAndPushNamed(context, Routes.PostList);
  }
}

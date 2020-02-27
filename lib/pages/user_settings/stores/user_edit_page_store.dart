import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_page_state_type.dart';

part 'user_edit_page_store.g.dart';

class UserEditPageStore = _UserSettingsPageStore with _$UserEditPageStore;

/// Состояние страницы настроек пользователя
abstract class _UserSettingsPageStore with Store {
  /// Состояние страницы
  @observable
  UserEditPageStateType state = UserEditPageStateType.Edit;

  /// Сохраняет пользователя
  @action
  Future updateUser(String name, String contact, String skill) async {
    state = UserEditPageStateType.Saving;

    await teamLeadService.userService.updateUser(name, contact, skill);
    state = UserEditPageStateType.Edit;
  }
}

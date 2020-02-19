import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/user_settings/stores/user_settings_page_state_type.dart';

part 'user_settings_page_store.g.dart';

class UserSettingsPageStore = _UserSettingsPageStore
    with _$UserSettingsPageStore;

/// Состояние страницы настроек пользователя
abstract class _UserSettingsPageStore with Store {
  /// Состояние страницы
  @observable
  UserSettingsPageStateType state = UserSettingsPageStateType.Edit;

  /// Сохраняет пользователя
  @action
  Future saveUser(String name, String contact, String skill) async {
    state = UserSettingsPageStateType.Saving;

    await Future.delayed(Duration(seconds: 2));
    teamLeadService.userService.saveUser(name, contact, skill);
    state = UserSettingsPageStateType.Edit;
  }
}

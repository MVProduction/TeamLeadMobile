import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_form_data.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_page_state_type.dart';

part 'user_create_page_store.g.dart';

class UserCreatePageStore = _UserCreatePageStore with _$UserCreatePageStore;

/// Состояние страницы создания пользователя
abstract class _UserCreatePageStore with Store {
  /// Состояние страницы
  @observable
  UserEditPageStateType state = UserEditPageStateType.Edit;

  /// Сохраняет пользователя
  @action
  Future createUser(UserEditFormData user) async {
    state = UserEditPageStateType.Saving;

    String photoUrl;
    if (user.photo != null) {
      photoUrl = "${user.id}_photo";
      teamLeadService.storageService.saveFile(photoUrl, user.photo);
    }

    final nuser = await teamLeadService.userService
        .createUser(user.id, photoUrl, user.name, user.contacts, user.skills);

    await teamLeadService.userService.login(nuser.id);
  }
}

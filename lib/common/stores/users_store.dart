import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';

part 'users_store.g.dart';

class UsersStore = _UsersStore with _$UsersStore;

/// Модель пользователей
abstract class _UsersStore with Store {
  ServiceUserData getLoginUser() {
    return teamLeadService.userService.getLoginUser();
  }
}

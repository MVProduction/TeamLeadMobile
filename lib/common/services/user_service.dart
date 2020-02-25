import 'package:team_lead/common/services/contracts/auth_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';

/// Сервис работы с пользователями
abstract class UserService {
  /// Подключается через гугл и возвращает информацию пользователя
  Future<AuthUserData> loginGoogle();

  /// Возвращает вошедшого пользователя
  ServiceUserData getLoginUser();

  /// Возвращает информацию пользователя по идентификатору
  Future<ServiceUserData> getUserInfoById(String id);

  /// Возвращает информацию пользователя по имени
  Future<ServiceUserData> getUserInfoByName(String userName);

  /// Сохраняет информацию пользователя
  Future saveUser(String name, String contact, String skill);
}

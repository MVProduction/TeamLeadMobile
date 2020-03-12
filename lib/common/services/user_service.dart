import 'package:team_lead/common/services/contracts/auth_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';

/// Сервис работы с пользователями
abstract class UserService {
  /// Идентификатор клиента github
  static const GithubClientId = "faba0c43bad7ca29524c";

  /// Секрет клиента github
  static const GithubClientSecret = "7cf504a993afbf78f494318d4ce53b5fc6cba355";

  /// Возвращает вошедшого пользователя
  ServiceUserData getLoginUser();

  /// Подключается к гугл и возвращает информацию пользователя
  /// Которую можно использовать для логина в приложение
  /// Или создать нового пользователя
  Future<AuthUserData> loginGoogle();

  /// Подключается к github и возвращает информацию пользователя
  /// Которую можно использовать для логина в приложение
  /// Или создать нового пользователя
  Future<AuthUserData> loginGithub(String code);

  /// Входит в приложение используя информацию полученную из провайдера
  /// Например гугл или github
  Future<ServiceUserData> login(String id);

  /// Возвращает информацию пользователя по идентификатору
  Future<ServiceUserData> getUserInfoById(String id);

  /// Создаёт пользователя, возвращает пользователя
  /// Идентификатор [id] должен быть получен от провайдера аутентификации
  Future<ServiceUserData> createUser(
      String id, String photoUrl, String name, String contacts, String skills);

  /// Сохраняет информацию пользователя
  Future updateUser(
      String photoUrl, String name, String contacts, String skills);
}

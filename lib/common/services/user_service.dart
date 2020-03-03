import 'package:team_lead/common/services/contracts/auth_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';

/// Сервис работы с пользователями
abstract class UserService {
  /// Возвращает вошедшого пользователя
  ServiceUserData getLoginUser();

  /// Подключается к гугл и возвращает информацию пользователя
  /// Которую можно использовать для логина в приложение
  /// Или создать нового пользователя
  Future<AuthUserData> loginGoogle();

  /// Подключается к github и возвращает информацию пользователя
  /// Которую можно использовать для логина в приложение
  /// Или создать нового пользователя
  Future<AuthUserData> loginGithub(int code);

  /// Входит в приложение используя информацию полученную из провайдера
  /// Например гугл или github
  Future<ServiceUserData> login(String id);

  /// Возвращает информацию пользователя по идентификатору
  Future<ServiceUserData> getUserInfoById(String id);

  /// Возвращает информацию пользователя по имени
  Future<ServiceUserData> getUserInfoByName(String userName);

  /// Создаёт пользователя, возвращает пользователя
  /// Идентификатор [id] должен быть получен от провайдера аутентификации
  Future<ServiceUserData> createUser(String id, String name, String contacts, String skills);

  /// Сохраняет информацию пользователя
  Future updateUser(String name, String contacts, String skills);
}

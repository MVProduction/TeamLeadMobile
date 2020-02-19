import 'package:team_lead/common/services/contracts/service_user_data.dart';

/// Сервис работы с пользователями
abstract class UserService {
  /// Возвращает вошедшого пользователя
  ServiceUserData getLoginUser();

  /// Возвращает информацию пользователя по имени
  Future<ServiceUserData> getUserInfo(String userName);

  /// Сохраняет информацию пользователя
  Future saveUser(String name, String contact, String skill);
}

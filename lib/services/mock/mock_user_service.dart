import 'package:team_lead/services/contracts/service_user_data.dart';
import 'package:team_lead/services/user_service.dart';

/// Тестовый сервис для работы с пользователями
class MockUserService extends UserService {
  /// Все пользователи
  final _allUsers = [
    ServiceUserData('Klifford', 'klifford@mail.ru', ''),
    ServiceUserData('Elis', 'elis@mail.ru', ''),
    ServiceUserData('Hzpriezz', 'hzpriezz@gmail.ru', ''),
  ];

  /// Возвращает вошедшего пользователя
  @override
  ServiceUserData getLoginUser() {
    return ServiceUserData("pytachok", "pytachock@gmail.com", "");
  }

  /// Возвращает информацию пользователя по имени
  @override
  Future<ServiceUserData> getUserInfo(String userName) async {
    return _allUsers.firstWhere((x) => x.name == userName, orElse: () => null);
  }
}

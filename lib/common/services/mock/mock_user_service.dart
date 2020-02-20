import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Тестовый сервис для работы с пользователями
class MockUserService extends UserService {
  /// Пользователь
  ServiceUserData _loginUser =
      ServiceUserData("pytachok", "pytachock@gmail.com", 'php, python', '');

  /// Все пользователи
  final _allUsers = [
    ServiceUserData('Klifford', 'klifford@mail.ru', '', ''),
    ServiceUserData('Elis', 'elis@mail.ru', '', ''),
    ServiceUserData('Hzpriezz', 'hzpriezz@gmail.ru', '', ''),
    ServiceUserData("pytachok", "pytachock@gmail.com", 'php, python', '')
  ];

  /// Возвращает вошедшего пользователя
  @override
  ServiceUserData getLoginUser() {
    return _loginUser;
  }

  /// Возвращает информацию пользователя по имени
  @override
  Future<ServiceUserData> getUserInfo(String userName) async {
    return _allUsers.firstWhere((x) => x.name == userName, orElse: () => null);
  }

  /// Сохраняет информацию пользователя
  Future saveUser(String name, String contact, String skill) async {
    _loginUser = ServiceUserData(name, contact, skill, '');
  }
}

import 'package:team_lead/common/services/contracts/auth_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Тестовый сервис для работы с пользователями
class MockUserService extends UserService {
  /// Пользователь
  ServiceUserData _loginUser = ServiceUserData(
      "pytachok", "pytachok", "pytachock@gmail.com", 'php, python', '');

  /// Все пользователи
  final _allUsers = [
    ServiceUserData('Klifford', 'Klifford', 'klifford@mail.ru', '', ''),
    ServiceUserData('Elis', 'Elis', 'elis@mail.ru', '', ''),
    ServiceUserData('Hzpriezz', 'Hzpriezz', 'hzpriezz@gmail.ru', '', ''),
    ServiceUserData(
        "pytachok", "pytachok", "pytachock@gmail.com", 'php, python', '')
  ];

  /// Возвращает вошедшего пользователя
  @override
  ServiceUserData getLoginUser() {
    return _loginUser;
  }

  /// Возвращает информацию пользователя по имени
  @override
  Future<ServiceUserData> getUserInfoByName(String userName) async {
    return _allUsers.firstWhere((x) => x.name == userName, orElse: () => null);
  }

  /// Сохраняет информацию пользователя
  Future updateUser(String name, String contact, String skill) async {
    final id = getLoginUser().id;
    _loginUser = ServiceUserData(id, name, contact, skill, '');
  }

  /// Возвращает информацию пользователя по идентификатору
  @override
  Future<ServiceUserData> getUserInfoById(String id) {
    return null;
  }

  /// Подключается через гугл и возвращает информацию пользователя
  @override
  Future<AuthUserData> loginGoogle() async {
    return AuthUserData("1234567890", "pytachok", "pytachok@gmail.com", "");
  }

  @override
  Future<ServiceUserData> createUser(
      String id, String name, String contact, String skill) async {
    return _loginUser;
  }

  @override
  Future<ServiceUserData> login(String id) async {
    return _loginUser;
  }
}

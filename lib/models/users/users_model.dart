import 'package:flutter/widgets.dart';
import 'package:team_lead/models/users/user_data.dart';

/// Модель для работы с пользователями
class UsersModel extends ChangeNotifier{
  /// Информация о вошедшем пользователе
  UserData loginUser;

  /// Устанавливает вошедшего пользователя
  void setLoginUser(UserData loginUser) {
    this.loginUser = loginUser;
    notifyListeners();
  }
}
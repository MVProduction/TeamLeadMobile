import 'dart:io';

import 'package:team_lead/common/services/contracts/service_user_data.dart';

/// Информация пользователя с фото
class UserWithPhoto {
  /// Информация пользователя
  final ServiceUserData user;

  /// Фото пользователя
  final File photo;

  /// Конструктор
  UserWithPhoto(this.user, this.photo);
}
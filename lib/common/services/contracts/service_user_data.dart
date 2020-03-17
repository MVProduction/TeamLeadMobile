import 'package:team_lead/common/services/contracts/service_base_user_data.dart';

/// Данные пользователя
class ServiceUserData extends ServiceBaseUserData {
  /// Идентификатор
  final String id;

  /// Имя пользователя
  final String name;

  /// Электронная почта
  final String contacts;

  /// Url для фото пользователя
  final String photoUrl;

  /// Навыки
  final String skills;

  /// Конструктор
  ServiceUserData(
      this.id, this.name, this.contacts, this.skills, this.photoUrl);
}

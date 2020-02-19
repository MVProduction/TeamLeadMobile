/// Данные пользователя
class ServiceUserData {
  /// Имя пользователя
  final String name;

  /// Электронная почта
  final String contacts;

  /// Url для фото пользователя
  final String photoUrl;

  /// Навыки
  final String skills;

  /// Конструктор
  ServiceUserData(this.name, this.contacts, this.skills, this.photoUrl);
}

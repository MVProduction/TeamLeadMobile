/// Данные пользователя
class ServiceUserData {
  /// Имя пользователя
  final String name;

  /// Электронная почта
  /// TODO: контакты
  final String email;

  /// Url для фото пользователя
  final String photoUrl;

  /// Конструктор
  ServiceUserData(this.name, this.email, this.photoUrl);  
}
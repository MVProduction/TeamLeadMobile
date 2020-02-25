/// Данные пользователя после аутентификации
class AuthUserData {
  /// Идентификатор пользователя
  final String id;

  /// Имя пользователя
  final String name;

  /// Электронная почта
  final String email;

  /// Url для фото пользователя
  final String photoUrl;

  /// Конструктор
  AuthUserData(this.id, this.name, this.email, this.photoUrl);
}

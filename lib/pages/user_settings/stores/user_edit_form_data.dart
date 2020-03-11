import 'dart:io';

/// Данные возвращаемые формой редактирования
class UserEditFormData {
  /// Идентификатор пользователя
  final String id;

  // Имя пользователя
  final String name;

  /// Контакты
  final String contacts;

  /// Скилы
  final String skills;

  /// Фотка пользователя
  /// null если не менялось
  final File photo;

  /// Конструктор
  UserEditFormData(this.id, this.name, this.contacts, this.skills, this.photo);
}

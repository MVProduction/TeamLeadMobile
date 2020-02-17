/// Информация о комментарии
class ServiceCommentData {
  /// Идентификатор комментария
  final int id;

  /// Имя пользователя сделавшего пост
  final String userName;

  /// Дата и время комментария
  final DateTime dateTime;

  /// Текст комментария
  final String text;

  /// Конструктор
  ServiceCommentData(this.id, this.userName, this.dateTime, this.text);
}

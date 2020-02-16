/// Информация о комментарии
class ServiceCommentData {
  /// Имя пользователя сделавшего пост
  final String userName;

  /// Дата и время комментария
  final DateTime dateTime;

  /// Текст комментария
  final String text;

  /// Конструктор
  ServiceCommentData(this.userName, this.dateTime, this.text);
}

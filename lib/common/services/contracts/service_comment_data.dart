/// Информация о комментарии
class ServiceCommentData {
  /// Идентификатор комментария
  final int id;

  /// Идентификатор поста
  final int postId;

  /// Идентификатор пользователя сделавшего пост
  final String userId;

  /// Дата и время комментария
  final DateTime dateTime;

  /// Текст комментария
  final String text;

  /// Конструктор
  ServiceCommentData(
      this.id, this.postId, this.userId, this.dateTime, this.text);
}

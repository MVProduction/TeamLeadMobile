/// Данные поста
class ServicePostData {
  /// ID поста
  final int id;

  /// Имя пользователя
  final String userId;

  /// Заголовок
  String title;

  /// Время создания поста
  final DateTime createDate;

  /// Описание поста
  String text;

  /// Количество просмотров
  final int viewCount;

  /// Колличество комментариев
  final int commentCount;

  /// Добавлено ли в избранное
  bool isFavorite;

  /// Конструктор
  ServicePostData(this.id, this.userId, this.title, this.createDate,
      this.text, this.viewCount, this.commentCount, this.isFavorite);

  @override
  String toString() {
    return """id: $id 
    userId: $userId 
    title: $title 
    createDate: $createDate 
    shortText: $text 
    viewCount: $viewCount
    commentCount: $commentCount
    isFavorite: $isFavorite
    """;
  }
}

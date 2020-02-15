/// Данные поста для списка присылаемые сервисом
class ServicePostData {
  /// ID поста
  final int id;

  /// Имя пользователя
  final String userName;

  /// Заголовок
  final String title;

  /// Время создания поста
  final DateTime createDate;

  /// Короткое описание поста
  final String shortText;

  /// Количество просмотров
  final int viewCount;

  /// Добавлено ли в избранное
  bool isFavorite;

  /// Конструктор
  ServicePostData(this.id, this.userName, this.title, this.createDate,
      this.shortText, this.viewCount, this.isFavorite);

  @override
  String toString() {    
    return """id: $id 
    userName: $userName 
    title: $title 
    createDate: $createDate 
    shortText: $shortText 
    viewCount: $viewCount
    isFavorite: $isFavorite
    """;
  }
}

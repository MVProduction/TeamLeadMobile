import 'package:team_lead/services/contracts/service_post_list_item_data.dart';

/// Данные поста
class PostData {
  /// ID поста
  final String id;

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
  final bool isFavorite;

  /// Создаёт из контракта сервиса
  static PostData fromServicePostListItemData(
      ServicePostListItemData data) {
    return PostData(data.id, data.userName, data.title, data.createDate,
        data.shortText, data.viewCount, data.isFavorite);
  }

  /// Конструктор
  PostData(this.id, this.userName, this.title, this.createDate,
      this.shortText, this.viewCount, this.isFavorite);
}

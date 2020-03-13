import 'package:team_lead/common/services/contracts/service_post_data.dart';

/// Сервис работы с постами
abstract class PostService {
  /// Возвращает идентификатор последнего поста
  Future<int> getLastPostId();

  /// Загружает посты с [firstId] в количестве
  Future<List<ServicePostData>> loadPosts(int firstId, int count);

  /// Загружает избранные посты
  Future<List<ServicePostData>> loadUserFavoritePosts(String userId);

  /// Загружает посты пользователя
  Future<List<ServicePostData>> loadUserPosts(String userId);

  /// Загружает полные данные поста с информацией пользователя
  Future<ServicePostData> loadPost(int postId);

  /// Отмечает что пост [postId] просмотрен пользователем [userId]
  Future viewPost(int postId, String userId);

  /// Добавляет пост в избранное
  Future addPostToFavorite(int postId);

  /// Удаляет из избранного
  Future removePostFromFavorite(int postId);

  /// Создаёт пост
  Future createPost(String userName, String title, String text);

  /// Редактирует пост
  Future editPost(int postId, String title, String text);
}

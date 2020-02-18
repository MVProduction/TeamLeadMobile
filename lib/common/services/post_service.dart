import 'package:team_lead/common/services/contracts/service_post_data.dart';

/// Сервис работы с постами
abstract class PostService {
  /// Загружает посты с [firstId] в количестве
  Future<List<ServicePostData>> loadPosts(int firstId, int count);

  /// Загружает избранные посты
  Future<List<ServicePostData>> loadUserFavoritePosts(String name);

  /// Загружает посты пользователя
  Future<List<ServicePostData>> loadUserPosts(String name);

  /// Загружает полные данные поста с информацией пользователя
  Future<ServicePostData> loadPost(int postId);

  /// Добавляет пост в избранное
  Future addPostToFavorite(int postId);

  /// Удаляет из избранного
  Future removePostFromFavorite(int postId);

  /// Создаёт пост
  Future createPost(String user, String title, String text);
}

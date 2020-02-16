import 'package:team_lead/services/contracts/service_comment_data.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/contracts/service_user_data.dart';
import 'package:team_lead/services/team_lead_mock_service.dart';

/// Экземпляр сервиса
final teamLeadService = TeamLeadMockService();

/// Интерфейс сервиса
abstract class TeamLeadService {
  /// Возвращает вошедшого пользователя
  ServiceUserData getLoginUser();

  /// Возвращает информацию пользователя по имени
  Future<ServiceUserData> getUserInfo(String userName);

  /// Загружает посты
  Future<List<ServicePostData>> loadPosts(int firstId, int count);

  /// Загружает избранные посты
  Future<List<ServicePostData>> loadUserFavoritePosts(String userName);

  /// Загружает посты пользователя
  Future<List<ServicePostData>> loadUserPosts(String userName);

  /// Загружает пост по идентификатору
  Future loadPost(int postId);

  /// Добавляет в избранное
  Future addPostToFavorite(int postId);

  /// Удаляет из избранного
  Future removePostFromFavorite(int postId);

  /// Загружает посты с [firstId] в количестве [count]
  Future<List<ServiceCommentData>> loadPostComments(
      int postId, int firstId, int count);
}

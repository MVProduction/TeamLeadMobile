import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_mock_service.dart';

/// Экземпляр сервиса
final teamLeadService = TeamLeadMockService();

/// Интерфейс сервиса
abstract class TeamLeadService {
  /// Загружает все посты
  Future<List<ServicePostData>> loadPosts(int index, int count);

  /// Загружает избранные посты
  Future<List<ServicePostData>> loadFavorite();

  /// Загружает посты пользователя
  Future<List<ServicePostData>> loadUserPosts();

  /// Добавляет в избранное
  Future addToFavorite(int postId);

  /// Удаляет из избранного
  Future removeFromFavorite(int postId);
}

import 'package:team_lead/services/contracts/service_post_list_item_data.dart';
import 'package:team_lead/services/team_lead_mock_service.dart';

/// Интерфейс сервиса
abstract class TeamLeadService {
  /// Экземпляр
  static final _instance = TeamLeadMockService();

  /// Возвращает сервис
  factory TeamLeadService() {
    return _instance;
  }

  /// Загружает все посты
  Future<List<ServicePostListItemData>> loadPosts();
}

import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_mock_service.dart';

/// Экземпляр сервиса
final teamLeadService = TeamLeadMockService();

/// Интерфейс сервиса
abstract class TeamLeadService {
  /// Загружает все посты
  Future<List<ServicePostData>> loadPosts();
}

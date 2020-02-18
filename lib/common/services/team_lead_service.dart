import 'package:team_lead/common/services/comment_service.dart';
import 'package:team_lead/common/services/mock/team_lead_mock_service.dart';
import 'package:team_lead/common/services/post_service.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Экземпляр сервиса
final teamLeadService = TeamLeadMockService();

/// Интерфейс сервиса
abstract class TeamLeadService {
  /// Сервис для работы с пользователями
  UserService get userService;

  /// Сервис для работы с постами
  PostService get postService;

  /// Сервис для работы с постами
  CommentService get commentService;
}

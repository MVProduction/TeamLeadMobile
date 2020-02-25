import 'package:team_lead/common/services/comment_service.dart';
import 'package:team_lead/common/services/post_service.dart';
import 'package:team_lead/common/services/real/team_lead_real_service.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Экземпляр сервиса
final teamLeadService = TeamLeadRealService();

/// Интерфейс сервиса
abstract class TeamLeadService {
  /// Сервис для работы с пользователями
  UserService get userService;

  /// Сервис для работы с постами
  PostService get postService;

  /// Сервис для работы с постами
  CommentService get commentService;
}

import 'package:team_lead/services/comment_service.dart';
import 'package:team_lead/services/contracts/service_comment_data.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/contracts/service_user_data.dart';
import 'package:team_lead/services/mock/team_lead_mock_service.dart';
import 'package:team_lead/services/post_service.dart';
import 'package:team_lead/services/user_service.dart';

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

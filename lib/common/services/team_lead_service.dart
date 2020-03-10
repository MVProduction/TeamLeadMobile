import 'package:team_lead/common/services/comment_service.dart';
import 'package:team_lead/common/services/firebase/team_lead_firebase_service.dart';
import 'package:team_lead/common/services/post_service.dart';
import 'package:team_lead/common/services/storage_service.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Экземпляр сервиса
final teamLeadService = TeamLeadFirebaseService();

/// Интерфейс сервиса
abstract class TeamLeadService {
  /// Сервис для хранения файлов
  StorageService get storageService;

  /// Сервис для работы с пользователями
  UserService get userService;

  /// Сервис для работы с постами
  PostService get postService;

  /// Сервис для работы с постами
  CommentService get commentService;
}

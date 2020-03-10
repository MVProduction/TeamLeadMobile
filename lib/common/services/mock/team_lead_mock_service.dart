import 'package:team_lead/common/services/mock/mock_comment_service.dart';
import 'package:team_lead/common/services/mock/mock_post_service.dart';
import 'package:team_lead/common/services/mock/mock_user_service.dart';
import 'package:team_lead/common/services/post_service.dart';
import 'package:team_lead/common/services/storage_service.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Тестовый сервис
class TeamLeadMockService implements TeamLeadService {
  /// Сервис пользователей
  final _userService = MockUserService();

  /// Сервис постов
  final _postService = MockPostService();

  /// Сервис комментариев
  final _commentService = MockCommentService();

  @override
  get commentService => _commentService;

  @override
  PostService get postService => _postService;

  @override
  UserService get userService => _userService;

  @override
  // TODO: implement storageService
  StorageService get storageService => throw UnimplementedError();
}

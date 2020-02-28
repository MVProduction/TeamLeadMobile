import 'package:team_lead/common/services/firebase/firebase_post_service.dart';
import 'package:team_lead/common/services/firebase/firebase_user_service.dart';
import 'package:team_lead/common/services/mock/mock_comment_service.dart';
import 'package:team_lead/common/services/post_service.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Сервис на основе Firebase
class TeamLeadFirebaseService implements TeamLeadService {
  /// Сервис пользователей
  final _userService = FirebaseUserService();

  /// Сервис постов
  final _postService = FirebasePostService();

  /// Сервис комментариев
  final _commentService = MockCommentService();

  @override
  get commentService => _commentService;

  @override
  PostService get postService => _postService;

  @override
  UserService get userService => _userService;
}

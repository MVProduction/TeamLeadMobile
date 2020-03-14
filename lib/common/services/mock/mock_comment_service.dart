import 'package:team_lead/common/services/comment_service.dart';
import 'package:team_lead/common/services/contracts/service_comment_data.dart';

/// Тестовый сервис для работы с комментариями
class MockCommentService extends CommentService {
  /// Комментарии к посту с идентификатором 1
  final _comments = [
    ServiceCommentData(1, 1, 'EGSP', DateTime(2020, 4, 12),
        "Идея неплохая, но не доработанная"),
    ServiceCommentData(
        2, 1, 'Elis', DateTime(2020, 5, 13), "Где то я это уже видел"),
    ServiceCommentData(
        3, 1, 'Alexander210483', DateTime(2020, 5, 14), "Написал на почту")
  ];

  /// Загружает комментарии для поста [postId] начиная с индекса [firstId] в количестве [count]
  @override
  Future<List<ServiceCommentData>> loadPostComments(
      int postId, int firstId, int count) async {
    if (postId == 1) {
      return _comments;
    }

    return [];
  }

  /// Отправляет комментарий
  @override
  Future sendComment(int postId, String userName, String text) async {
    _comments
        .add(ServiceCommentData(0, postId, userName, DateTime.now(), text));
  }

  @override
  Future<int> getLastCommentId(int postId) async {
    return 0;
  }
}

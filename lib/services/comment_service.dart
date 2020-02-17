import 'package:team_lead/services/contracts/service_comment_data.dart';

/// Сервис для работы с комментариями
abstract class CommentService {
  /// Загружает комментарии для поста [postId] начиная с индекса [firstId] в количестве [count]
  Future<List<ServiceCommentData>> loadPostComments(
      int postId, int firstId, int count);
}

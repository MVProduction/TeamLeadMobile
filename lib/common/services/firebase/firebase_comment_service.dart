import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_lead/common/services/comment_service.dart';
import 'package:team_lead/common/services/contracts/service_comment_data.dart';

/// Сервис комментариев на основе Firebase
class FirebaseCommentService extends CommentService {
  /// Создаёт комментарий из документа Firebird
  ServiceCommentData documentToComment(Map<String, dynamic> data) {
    return ServiceCommentData(
        data["id"],
        data["postId"],
        data["userName"],
        data["userPhotoUrl"],
        (data["dateTime"] as Timestamp).toDate(),
        data["text"]);
  }

  /// Преобразует комментарий в документ
  Map<String, dynamic> commentToDocument(ServiceCommentData data) {
    return {
      "id": data.id,
      "postId": data.postId,
      "userName": data.userName,
      "userPhotoUrl": data.userPhotoUrl,
      "dateTime": data.dateTime,
      "text": data.text
    };
  }

  /// Возвращает идентификатор последнего последний
  @override
  Future<int> getLastCommentId(int postId) async {
    final postIdStr = postId.toString();
    final postDoc =
        await Firestore.instance.collection('posts').document(postIdStr).get();
    if (postDoc.exists) {
      final index = postDoc.data["lastCommentId"] ?? 0;
      print("lastCommentId: $index");
      return index;
    }

    return 0;
  }

  /// Загружает комментарии для поста
  @override
  Future<List<ServiceCommentData>> loadPostComments(
      int postId, int firstId, int count) async {
    final commentDocs = await Firestore.instance
        .collection('comments')
        .where("postId", isEqualTo: postId)
        .getDocuments();

    print("commentDocs.documents: ${commentDocs.documents.length}");
    return commentDocs.documents
        .where((x) => x.exists)
        .map((e) => documentToComment(e.data))
        .toList();
  }

  /// Отправляет комментарий для поста и пользователя
  @override
  Future sendComment(int postId, String userName, String text) async {
    final id = await getLastCommentId(postId) + 1;
    final data = commentToDocument(
        ServiceCommentData(id, postId, userName, "", DateTime.now(), text));

    await Firestore.instance.collection('comments').document().setData(data);

    await Firestore.instance
        .collection('posts')
        .document(postId.toString())
        .updateData({"lastCommentId": id});
  }
}

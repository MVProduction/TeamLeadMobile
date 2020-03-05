import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/post_service.dart';

/// Сервис постов на основе Firebase
class FirebasePostService extends PostService {
  /// Создаёт Post из документа Firebird
  ServicePostData _documentToPost(Map<String, dynamic> data) {
    return ServicePostData(
        data["id"],
        data["userName"],
        data["title"],
        (data["createDate"] as Timestamp).toDate(),
        data["text"],
        data["viewCount"],
        data["lastCommentId"],
        data["isFavorite"]);
  }

  /// Преобразует Post в документ
  Map<String, dynamic> _postToDocument(ServicePostData data) {
    return {
      "id": data.id,
      "userName": data.userName,
      "title": data.title,
      "createDate": data.createDate,
      "text": data.text,
      "viewCount": data.viewCount,
      "commentCount": data.commentCount,
      "isFavorite": data.isFavorite,
    };
  }

  /// Создаёт пост
  @override
  Future createPost(String userName, String title, String text) async {
    final id = await getLastPostId() + 1;
    final data = _postToDocument(ServicePostData(
        id, userName, title, DateTime.now(), text, 0, 0, false));

    await Firestore.instance
        .collection('posts')
        .document(id.toString())
        .setData(data);

    await Firestore.instance
        .collection('indexes')
        .document('post')
        .setData({"index": id});
  }

  /// Редактирует пост
  @override
  Future editPost(int postId, String title, String text) async {
    await Firestore.instance
        .collection('posts')
        .document(postId.toString())
        .updateData({"title": title, "text": text});
  }

  /// Возвращает последний индекс поста
  @override
  Future<int> getLastPostId() async {
    final postIndexDoc =
        await Firestore.instance.collection('indexes').document('post').get();
    if (postIndexDoc.exists) {
      final index = postIndexDoc.data["index"];
      print("index: $index");
      return index;
    }

    await Firestore.instance
        .collection('indexes')
        .document('post')
        .setData({"index": 0});

    return 0;
  }

  /// Загружает пост
  @override
  Future<ServicePostData> loadPost(int postId) async {
    final postDoc = await Firestore.instance
        .collection('posts')
        .document(postId.toString())
        .get();

    if (!postDoc.exists) {
      return null;
    }

    return _documentToPost(postDoc.data);
  }

  /// Отмечает что пост [postId] просмотрен пользователем [userId]
  Future viewPost(int postId, String userId) async {
    final post = await loadPost(postId);
    if (post == null) {
      return;
    }

    final viewerDoc = await Firestore.instance
        .collection('post_viewers')
        .where("postId", isEqualTo: postId)
        .where("userId", isEqualTo: userId)
        .limit(1)
        .getDocuments();

    // Отмечает просмотр
    if (viewerDoc.documents.isEmpty) {
      await Firestore.instance
          .collection("posts")
          .document(postId.toString())
          .updateData({"viewCount": post.viewCount + 1});

      await Firestore.instance
          .collection('post_viewers')
          .document()
          .setData({"postId": postId, "userId": userId});
    }
  }

  @override
  Future<List<ServicePostData>> loadPosts(int firstId, int count) async {
    print("firstId: $firstId count: $count");

    final postDocs = await Firestore.instance
        .collection('posts')
        .where("id", isLessThanOrEqualTo: firstId)
        .orderBy("id", descending: true)
        .limit(count)
        .getDocuments();

    print("postDocs.documents: ${postDocs.documents.length}");
    return postDocs.documents
        .where((x) => x.exists)
        .map((e) => _documentToPost(e.data))
        .toList();
  }

  /// Возвращает избранные посты
  @override
  Future<List<ServicePostData>> loadUserFavoritePosts(String userName) async {
    final postDocs = await Firestore.instance
        .collection('posts')
        .where("userName", isEqualTo: userName)
        .where("isFavorite", isEqualTo: true)
        .orderBy("id", descending: true)
        .getDocuments();

    print("postDocs.documents: ${postDocs.documents.length}");
    return postDocs.documents
        .where((x) => x.exists)
        .map((e) => _documentToPost(e.data))
        .toList();
  }

  /// Загружает посты пользователя
  @override
  Future<List<ServicePostData>> loadUserPosts(String userName) async {
    final postDocs = await Firestore.instance
        .collection('posts')
        .where("userName", isEqualTo: userName)
        .orderBy("id", descending: true)
        .getDocuments();

    print("postDocs.documents: ${postDocs.documents.length}");
    return postDocs.documents
        .where((x) => x.exists)
        .map((e) => _documentToPost(e.data))
        .toList();
  }

  /// Добавляет пост в избранное
  @override
  Future addPostToFavorite(int postId) async {
    await Firestore.instance
        .collection('posts')
        .document(postId.toString())
        .updateData({"isFavorite": true});
  }

  /// Удаляет из избранного
  @override
  Future removePostFromFavorite(int postId) async {
    await Firestore.instance
        .collection('posts')
        .document(postId.toString())
        .updateData({"isFavorite": false});
  }
}

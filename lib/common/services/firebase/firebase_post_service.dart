import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/post_service.dart';

/// Сервис постов на основе Firebase
class FirebasePostService extends PostService {
  /// Создаёт Post из документа Firebird
  ServicePostData documentToPost(Map<String, dynamic> data) {
    return ServicePostData(
        data["id"],
        data["userName"],
        data["title"],
        (data["createDate"] as Timestamp).toDate(),
        data["text"],
        data["viewCount"],
        data["isFavorite"]);
  }

  /// Преобразует Post в документ
  Map<String, dynamic> postToDocument(ServicePostData data) {
    return {
      "id": data.id,
      "userName": data.userName,
      "title": data.title,
      "createDate": data.createDate,
      "text": data.text,
      "viewCount": data.viewCount,
      "isFavorite": data.isFavorite,
    };
  }

  /// Создаёт пост
  @override
  Future createPost(String userName, String title, String text) async {
    final id = await getLastPostId() + 1;
    final data = postToDocument(
        ServicePostData(id, userName, title, DateTime.now(), text, 0, false));

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

    return documentToPost(postDoc.data);
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
        .map((e) => documentToPost(e.data))
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
        .map((e) => documentToPost(e.data))
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
        .map((e) => documentToPost(e.data))
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

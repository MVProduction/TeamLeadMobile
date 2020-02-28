import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/post_service.dart';

/// Сервис постов на основе Firebase
class FirebasePostService extends PostService {
  @override
  Future addPostToFavorite(int postId) {
    // TODO: implement addPostToFavorite
    throw UnimplementedError();
  }

  @override
  Future createPost(String user, String title, String text) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future editPost(int postId, String title, String text) {
    // TODO: implement editPost
    throw UnimplementedError();
  }

  /// Возвращает последний индекс поста
  @override
  Future<int> getLastPostId() async {
    final postIndexDoc =
        await Firestore.instance.collection('indexes').document('post').get();
    if (postIndexDoc.exists) {
      return postIndexDoc.data["index"];
    }

    await Firestore.instance
        .collection('indexes')
        .document('post')
        .setData({"index": 0});

    return 0;
  }

  @override
  Future<ServicePostData> loadPost(int postId) {
    // TODO: implement loadPost
    throw UnimplementedError();
  }

  @override
  Future<List<ServicePostData>> loadPosts(int firstId, int count) async {
    // final postDocs =
    //     await Firestore.instance.collection('posts').where()
  }

  @override
  Future<List<ServicePostData>> loadUserFavoritePosts(String name) {
    // TODO: implement loadUserFavoritePosts
    throw UnimplementedError();
  }

  @override
  Future<List<ServicePostData>> loadUserPosts(String name) {
    // TODO: implement loadUserPosts
    throw UnimplementedError();
  }

  @override
  Future removePostFromFavorite(int postId) {
    // TODO: implement removePostFromFavorite
    throw UnimplementedError();
  }
}

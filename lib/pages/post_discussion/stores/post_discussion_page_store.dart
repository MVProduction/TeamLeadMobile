import 'package:mobx/mobx.dart';
import 'package:team_lead/pages/post_discussion/stores/post_with_user_data.dart';
import 'package:team_lead/services/contracts/service_comment_data.dart';
import 'package:team_lead/services/team_lead_service.dart';

part 'post_discussion_page_store.g.dart';

class PostDiscussionPageStore = _PostDiscussionPageStore
    with _$PostDiscussionPageStore;

/// Состояние страницы обсуджения
abstract class _PostDiscussionPageStore with Store {
  /// Идентификатор поста
  int _postId;

  /// Кэш комментариев
  List<ServiceCommentData> _commentsCache = [];

  /// Для загрузки поста
  @observable
  ObservableFuture<PostWithUserData> post;

  /// Комментарии
  @observable
  ObservableFuture<List<ServiceCommentData>> comments;

  /// Устанавливает идентификатор поста
  void setPostId(int postId) {
    _postId = postId;
  }

  /// Загружает данные поста
  @action
  Future fetchPost() {
    post = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      final post = await teamLeadService.postService.loadPost(_postId);
      final user = await teamLeadService.userService.getUserInfo(post.userName);
      return PostWithUserData(user, post);
    }));

    return post;
  }

  /// Загружает данные поста
  @action
  Future fetchComments() {
    comments = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      _commentsCache.clear();
      _commentsCache.addAll(
          await teamLeadService.commentService.loadPostComments(_postId, 0, 5));
      return _commentsCache;
    }));
    return comments;
  }

  /// Загружает старые посты
  Future fetchOldComments() async {
    final comments = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      final newPosts = await teamLeadService.commentService
          .loadPostComments(_postId, _commentsCache.length, 3);
      _commentsCache.clear();
      _commentsCache.addAll(newPosts);
      return _commentsCache;
    }));
    return comments;
  }
}

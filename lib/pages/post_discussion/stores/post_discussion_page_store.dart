import 'package:mobx/mobx.dart';
import 'package:team_lead/common/models/comment_with_user_data.dart';
import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/services/helpers/post_service_helper.dart';
import 'package:team_lead/common/services/helpers/comment_service_helper.dart';

part 'post_discussion_page_store.g.dart';

class PostDiscussionPageStore = _PostDiscussionPageStore
    with _$PostDiscussionPageStore;

/// Состояние страницы обсуджения
abstract class _PostDiscussionPageStore with Store {
  /// Максимальное количество комментариев в одном запросе
  static const MaxCommentRequest = 5;

  /// Идентификатор поста
  int _postId;

  /// Кэш комментариев
  List<CommentWithUserData> _commentsCache = [];

  /// Для загрузки поста
  @observable
  ObservableFuture<PostWithUserData> post;

  /// Количество постов
  @computed
  int get commentCount => post.value.postLastCommentId ?? 0;

  /// Комментарии
  @observable
  ObservableFuture<List<CommentWithUserData>> comments;

  /// Устанавливает идентификатор поста
  void setPostId(int postId) {
    _postId = postId;
  }

  /// Отправляет комментарий
  Future sendComment(String text) async {
    final user = teamLeadService.userService.getLoginUser();
    await teamLeadService.commentService.sendComment(_postId, user.id, text);
    await fetchPost();
  }

  /// Загружает данные поста
  @action
  Future fetchPost() {
    post = ObservableFuture(Future(() async {
      final post = await teamLeadService.postService.loadPost(_postId);
      await fetchComments();

      final nposts = await teamLeadService.postService.loadPostsWithUserData(
          [post], teamLeadService.userService, teamLeadService.storageService);

      return nposts.first;
    }));

    return post;
  }

  /// Загружает данные поста
  @action
  Future fetchComments() {
    comments = ObservableFuture(Future(() async {
      final post = await teamLeadService.postService.loadPost(_postId);

      final comms = await teamLeadService.commentService
          .loadPostComments(_postId, post.lastCommentId, MaxCommentRequest);

      final ncomms = await teamLeadService.commentService
          .loadCommentsWithUserData(comms, teamLeadService.userService,
              teamLeadService.storageService);

      _commentsCache.clear();
      _commentsCache.addAll(ncomms);
      return _commentsCache;
    }));
    return comments;
  }

  /// Загружает старые посты
  Future fetchOldComments() async {
    final comments = ObservableFuture(Future(() async {
      final newPosts = await teamLeadService.commentService.loadPostComments(
          _postId, _commentsCache.last.commentId - 1, MaxCommentRequest);

      final ncomms = await teamLeadService.commentService
          .loadCommentsWithUserData(newPosts, teamLeadService.userService,
              teamLeadService.storageService);

      _commentsCache.addAll(ncomms);
      return _commentsCache;
    }));
    return comments;
  }
}

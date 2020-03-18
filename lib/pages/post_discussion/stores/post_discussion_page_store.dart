import 'package:mobx/mobx.dart';
import 'package:team_lead/common/models/comment_with_user_data.dart';
import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/services/contracts/service_anonymous_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
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

  /// Необходимо отображать кнопку редактирования объявления
  @observable
  bool needShowEdit = true;

  /// Признак анонимного входа
  @computed
  bool get isAnonymous => (teamLeadService.userService.getLoginUser() is ServiceAnonymousUserData);

  /// Отправляет комментарий
  Future sendComment(int postId, String text) async {
    final user = teamLeadService.userService.getLoginUser() as ServiceUserData;
    await teamLeadService.commentService.sendComment(postId, user.id, text);
    await fetchPost(postId);
  }

  /// Загружает данные поста
  @action
  Future fetchPost(int postId) {
    post = ObservableFuture(Future(() async {
      final post = await teamLeadService.postService.loadPost(postId);
      await fetchComments(postId);

      final nposts = await teamLeadService.postService.loadPostsWithUserData(
          [post], teamLeadService.userService, teamLeadService.storageService);

      return nposts.first;
    }));

    return post;
  }

  /// Загружает данные поста
  @action
  Future fetchComments(int postId) {
    comments = ObservableFuture(Future(() async {
      final post = await teamLeadService.postService.loadPost(postId);

      final comms = await teamLeadService.commentService
          .loadPostComments(postId, post.lastCommentId, MaxCommentRequest);

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
  Future fetchOldComments(int postId) async {
    final comments = ObservableFuture(Future(() async {
      final newPosts = await teamLeadService.commentService.loadPostComments(
          postId, _commentsCache.last.commentId - 1, MaxCommentRequest);

      final ncomms = await teamLeadService.commentService
          .loadCommentsWithUserData(newPosts, teamLeadService.userService,
              teamLeadService.storageService);

      _commentsCache.addAll(ncomms);
      return _commentsCache;
    }));
    return comments;
  }
}

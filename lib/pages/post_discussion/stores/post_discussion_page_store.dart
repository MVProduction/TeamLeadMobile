import 'package:mobx/mobx.dart';
import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/services/contracts/service_comment_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';

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

  /// Количество постов
  @computed
  int get commentCount => post.value.postCommentCount;

  /// Комментарии
  @observable
  ObservableFuture<List<ServiceCommentData>> comments;

  /// Устанавливает идентификатор поста
  void setPostId(int postId) {
    _postId = postId;
  }

  /// Отправляет комментарий
  Future sendComment(String text) async {
    final user = teamLeadService.userService.getLoginUser();
    await teamLeadService.commentService.sendComment(_postId, user.name, text);
    await fetchComments();
    await fetchPost();
  }

  /// Загружает данные поста
  @action
  Future fetchPost() {
    post = ObservableFuture(Future(() async {
      final post = await teamLeadService.postService.loadPost(_postId);
      final user =
          await teamLeadService.userService.getUserInfoById(post.userId);
      await teamLeadService.postService.viewPost(_postId, user.id);
      return PostWithUserData(
          userId: user.id,
          userName: user.name,
          userContacts: user.contacts,
          userSkills: user.skills,
          userPhotoUrl: user.photoUrl,
          userPhoto: null,
          postId: post.id,
          postTitle: post.title,
          postText: post.text,
          postCreateDate: post.createDate,
          postViewCount: post.viewCount,
          postCommentCount: post.commentCount);
    }));

    return post;
  }

  /// Загружает данные поста
  @action
  Future fetchComments() {
    comments = ObservableFuture(Future(() async {
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
      final newPosts = await teamLeadService.commentService
          .loadPostComments(_postId, _commentsCache.length, 3);
      _commentsCache.clear();
      _commentsCache.addAll(newPosts);
      return _commentsCache;
    }));
    return comments;
  }
}

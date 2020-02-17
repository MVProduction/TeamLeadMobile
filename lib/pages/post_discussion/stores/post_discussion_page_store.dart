import 'package:mobx/mobx.dart';
import 'package:team_lead/pages/post_discussion/stores/post_with_user_data.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_service.dart';

part 'post_discussion_page_store.g.dart';

class PostDiscussionPageStore = _PostDiscussionPageStore
    with _$PostDiscussionPageStore;

/// Состояние страницы обсуджения
abstract class _PostDiscussionPageStore with Store {
  /// Для загрузки поста
  @observable
  ObservableFuture<PostWithUserData> post;

  /// Загружает данные поста
  @action
  Future fetchPost(int postId) {
    post = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      final post = await teamLeadService.postService.loadPost(postId);
      final user = await teamLeadService.userService.getUserInfo(post.userName);
      return PostWithUserData(user, post);
    }));

    return post;
  }
}

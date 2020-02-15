import 'package:mobx/mobx.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_service.dart';

part 'post_discussion_page_store.g.dart';

class PostDiscussionPageStore = _PostDiscussionPageStore
    with _$PostDiscussionPageStore;

/// Состояние страницы обсуджения
abstract class _PostDiscussionPageStore with Store {
  /// Для загрузки поста
  @observable
  ObservableFuture<ServicePostData> post;

  /// Загружает данные поста
  @action
  Future fetchPost(int postId) {
    post = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      return await teamLeadService.loadPost(postId);
    }));

    return post;
  }
}

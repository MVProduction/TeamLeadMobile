import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/post_edit/stores/post_edit_state_type.dart';

part 'post_edit_page_store.g.dart';

class PostEditPageStore = _PostEditPageStore with _$PostEditPageStore;

/// Состояние страницы редактированием поста
abstract class _PostEditPageStore with Store {
  /// Загружаемый пост
  @observable
  ServicePostData post;

  /// Состояние страницы
  @observable
  PostEditStateType state = PostEditStateType.Load;

  /// Получает пост по id
  @action
  Future fetchPost(int postId) async {
    state = PostEditStateType.Load;
    await Future.delayed(Duration(seconds: 2));
    post = await teamLeadService.postService.loadPost(postId);
    state = PostEditStateType.Edit;
  }

  /// Редактирует пост
  @action
  Future editPost(int postId, String title, String text) async {
    state = PostEditStateType.PendingSave;
    await Future.delayed(Duration(seconds: 2));
    await teamLeadService.postService.editPost(postId, title, text);
    post = await teamLeadService.postService.loadPost(postId);
    state = PostEditStateType.Edit;
  }
}

import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/post_edit/stores/post_create_state_type.dart';

part 'post_create_page_store.g.dart';

class PostCreatePageStore = _PostCreatePageStore with _$PostCreatePageStore;

/// Состояние страницы созданием поста
abstract class _PostCreatePageStore with Store {
  /// Состояние страницы
  @observable
  PostCreateStateType state = PostCreateStateType.Edit;

  /// Создаёт пост
  @action
  Future createPost(String title, String text) async {
    state = PostCreateStateType.PendingSave;
    await Future.delayed(Duration(seconds: 2));
    final user = teamLeadService.userService.getLoginUser();
    await teamLeadService.postService.createPost(user.name, title, text);
    state = PostCreateStateType.Created;
  }
}

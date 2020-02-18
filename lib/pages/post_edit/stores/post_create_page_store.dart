import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/post_edit/stores/post_edit_state_type.dart';

part 'post_create_page_store.g.dart';

class PostCreatePageStore = _PostCreatePageStore with _$PostCreatePageStore;

/// Состояние страницы создания поста
abstract class _PostCreatePageStore with Store {
  /// Состояние страницы
  @observable
  PostEditStateType state = PostEditStateType.Edit;

  /// Создаёт пост
  Future createPost(String title, String text) async {
    final user = teamLeadService.userService.getLoginUser();
    await teamLeadService.postService.createPost(user.name, title, text);
  }
}

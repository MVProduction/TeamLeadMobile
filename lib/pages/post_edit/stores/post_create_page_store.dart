import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
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
    final user = teamLeadService.userService.getLoginUser() as ServiceUserData;
    await teamLeadService.postService.createPost(user.id, title, text);
  }
}

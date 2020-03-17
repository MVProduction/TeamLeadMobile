import 'package:mobx/mobx.dart';
import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/services/helpers/post_service_helper.dart';

part 'user_post_list_store.g.dart';

class UserPostListStore = _UserPostListStore with _$UserPostListStore;

/// Состояние списка постов пользователя
abstract class _UserPostListStore with Store {
  /// Кэш всех постов
  final _postCache = List<PostWithUserData>();

  /// Все посты
  @observable
  ObservableFuture<List<PostWithUserData>> allPosts =
      ObservableFuture.value([]);

  /// Загружает избранные посты если есть
  @action
  Future fetchPosts() async {
    print("_UserPostListStore fetchPosts");
    allPosts = ObservableFuture(Future(() async {
      final user = teamLeadService.userService.getLoginUser() as ServiceUserData;
      final posts = await teamLeadService.postService.loadUserPosts(user.id);
      final nposts = await teamLeadService.postService.loadPostsWithUserData(
          posts, teamLeadService.userService, teamLeadService.storageService);

      _postCache.clear();
      _postCache.addAll(nposts);
      return _postCache;
    }));
    return allPosts;
  }
}

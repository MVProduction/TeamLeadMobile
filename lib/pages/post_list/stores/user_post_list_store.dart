import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';

part 'user_post_list_store.g.dart';

class UserPostListStore = _UserPostListStore with _$UserPostListStore;

/// Состояние списка постов пользователя
abstract class _UserPostListStore with Store {
  /// Кэш всех постов
  final _postCache = List<ServicePostData>();

  /// Все посты
  @observable
  ObservableFuture<List<ServicePostData>> allPosts = ObservableFuture.value([]);

  /// Загружает избранные посты если есть
  @action
  Future fetchPosts() async {
    print("_UserPostListStore fetchPosts");
    allPosts = ObservableFuture(Future(() async {
      final user = teamLeadService.userService.getLoginUser();
      _postCache.clear();
      _postCache
          .addAll(await teamLeadService.postService.loadUserPosts(user.name));
      return _postCache;
    }));
    return allPosts;
  }
}

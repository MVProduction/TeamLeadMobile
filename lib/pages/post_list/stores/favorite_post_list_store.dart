import 'package:mobx/mobx.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_service.dart';

part 'favorite_post_list_store.g.dart';

class FavoritePostListStore = _FavoritePostListStore
    with _$FavoritePostListStore;

/// Состояние списка избранных постов
abstract class _FavoritePostListStore with Store {
  /// Кэш всех постов
  final _postCache = List<ServicePostData>();

  /// Все посты
  @observable
  ObservableFuture<List<ServicePostData>> allPosts = ObservableFuture.value([]);

  /// Удаляет пост из списка
  @action
  void removePost(int postId) {
    _postCache.removeWhere((x) => x.id == postId);
    allPosts = ObservableFuture.value(_postCache);
  }

  /// Загружает избранные посты если есть
  @action
  Future fetchPosts() async {
    allPosts = ObservableFuture(Future(() async {
      final user = teamLeadService.userService.getLoginUser();
      await Future.delayed(Duration(seconds: 2));
      _postCache.clear();
      _postCache.addAll(
          await teamLeadService.postService.loadUserFavoritePosts(user.name));
      return _postCache;
    }));
    return allPosts;
  }
}

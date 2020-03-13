import 'package:mobx/mobx.dart';
import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/services/helpers/post_service_helper.dart';

part 'favorite_post_list_store.g.dart';

class FavoritePostListStore = _FavoritePostListStore
    with _$FavoritePostListStore;

/// Состояние списка избранных постов
abstract class _FavoritePostListStore with Store {
  /// Кэш всех постов
  final _postCache = List<PostWithUserData>();

  /// Все посты
  @observable
  ObservableFuture<List<PostWithUserData>> allPosts =
      ObservableFuture.value([]);

  /// Удаляет пост из списка
  @action
  void removePost(int postId) {
    _postCache.removeWhere((x) => x.postId == postId);
    allPosts = ObservableFuture.value(_postCache);
  }

  /// Загружает избранные посты если есть
  @action
  Future fetchPosts() async {
    print("_FavoritePostListStore fetchPosts");
    allPosts = ObservableFuture(Future(() async {
      final user = teamLeadService.userService.getLoginUser();

      final posts =
          await teamLeadService.postService.loadUserFavoritePosts(user.id);

      final nposts = await teamLeadService.postService.loadPostsWithUserData(
          posts, teamLeadService.userService, teamLeadService.storageService);

      _postCache.clear();
      _postCache.addAll(nposts);
      return _postCache;
    }));
    return allPosts;
  }
}

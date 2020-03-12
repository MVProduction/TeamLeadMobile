import 'package:mobx/mobx.dart';
import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/services/helpers/post_service_helper.dart';

part 'main_post_list_store.g.dart';

class MainPostListStore = _MainPostListStore with _$MainPostListStore;

/// Состояние основного списка постов
abstract class _MainPostListStore with Store {
  /// Максимальное количество постов в запросе
  static const MaxPostPerRequest = 5;

  /// Кэш всех постов
  final _postCache = List<PostWithUserData>();

  /// Все посты
  @observable
  ObservableFuture<List<PostWithUserData>> allPosts =
      ObservableFuture.value([]);

  /// Загружает новые посты если есть
  @action
  Future fetchPosts() async {
    print("_MainPostListStore fetchPosts");
    allPosts = ObservableFuture(Future(() async {
      final lastId = await teamLeadService.postService.getLastPostId();
      final posts = await teamLeadService.postService
          .loadPosts(lastId, MaxPostPerRequest);

      final nposts = await teamLeadService.postService.loadPostsWithUserData(
          posts, teamLeadService.userService, teamLeadService.storageService);
      _postCache.clear();
      _postCache.addAll(nposts);
      return _postCache;
    }));
    return allPosts;
  }

  /// Загружает старые посты
  Future fetchOld() async {
    print("fetchOld");
    final allFuture = ObservableFuture(Future(() async {
      final posts = await teamLeadService.postService
          .loadPosts(_postCache.last.postId - 1, MaxPostPerRequest);

      final nposts = await teamLeadService.postService.loadPostsWithUserData(
          posts, teamLeadService.userService, teamLeadService.storageService);
      _postCache.addAll(nposts);
      return _postCache;
    }));
    return allFuture;
  }
}

import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';

part 'main_post_list_store.g.dart';

class MainPostListStore = _MainPostListStore with _$MainPostListStore;

/// Состояние основного списка постов
abstract class _MainPostListStore with Store {
  /// Максимальное количество постов в запросе
  static const MaxPostPerRequest = 5;

  /// Кэш всех постов
  final _postCache = List<ServicePostData>();

  /// Все посты
  @observable
  ObservableFuture<List<ServicePostData>> allPosts = ObservableFuture.value([]);

  /// Загружает новые посты если есть
  @action
  Future fetchPosts() async {
    allPosts = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      _postCache.clear();
      final lastId = await teamLeadService.postService.getLastPostId();
      _postCache.addAll(await teamLeadService.postService
          .loadPosts(lastId, MaxPostPerRequest));
      return _postCache;
    }));
    return allPosts;
  }

  /// Загружает старые посты
  Future fetchOld() async {
    final allFuture = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      final newPosts = await teamLeadService.postService
          .loadPosts(_postCache.first.id - 1, MaxPostPerRequest);
      _postCache.addAll(newPosts);
      return _postCache;
    }));
    return allFuture;
  }
}

import 'package:mobx/mobx.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_service.dart';

part 'main_post_list_store.g.dart';

class MainPostListStore = _MainPostListStore with _$MainPostListStore;

/// Состояние основного списка постов
abstract class _MainPostListStore with Store {
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
      _postCache.addAll(await teamLeadService.loadPosts(0, 5));
      return _postCache;
    }));
    return allPosts;
  }

  /// Загружает старые посты
  Future fetchOld() async {
    allPosts = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      final newPosts = await teamLeadService.loadPosts(_postCache.length, 3);
      _postCache.addAll(newPosts);
      return _postCache;
    }));
    return allPosts;
  }
}

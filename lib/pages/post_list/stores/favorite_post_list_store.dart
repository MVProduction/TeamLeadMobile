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

  /// Загружает избранные посты если есть
  @action
  Future fetchPosts() async {
    allPosts = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      _postCache.clear();
      _postCache.addAll(await teamLeadService.loadFavorite());
      return _postCache;
    }));
    return allPosts;
  }
}

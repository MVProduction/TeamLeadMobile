import 'package:mobx/mobx.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_service.dart';

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
    allPosts = ObservableFuture(Future(() async {
      final user = teamLeadService.getLoginUser();
      await Future.delayed(Duration(seconds: 2));
      _postCache.clear();
      _postCache.addAll(await teamLeadService.loadUserPosts(user.name));
      return _postCache;
    }));
    return allPosts;
  }
}

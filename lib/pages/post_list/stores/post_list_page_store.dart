import 'package:mobx/mobx.dart';
import 'package:team_lead/pages/post_list/stores/post_tab_type.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_service.dart';
import 'package:team_lead/team_lead_app_store.dart';

part 'post_list_page_store.g.dart';

class PostListPageStore = _PostListPageStore with _$PostListPageStore;

/// Состояние страницы постов
abstract class _PostListPageStore with Store {
  /// Тип вкладки
  @observable
  PostTabType tabType = PostTabType.All;

  /// Необходимо отображать панель поиска
  @observable
  bool needShowSearchPanel = false;

  /// Необходимо отображать кнопку поиска
  @observable
  bool needShowSearchButton = true;

  /// Посты
  @observable
  ObservableList<ServicePostData> allPosts = ObservableList.of([]);

  /// Устанавливает отображать или нет панель поиска
  @action
  void setNeedShowSearchPanel(bool value) {
    needShowSearchPanel = value;
  }

  /// Устанавливает отображать или нет кнопку поиска
  @action
  void setNeedShowSearchButton(bool value) {
    needShowSearchButton = value;
  }

  /// Загружает ещё посты и добавляет в список
  Future loadMore() async {
    final newPosts = await loadPosts(allPosts.length, 3);
    this.allPosts.addAll(newPosts);
  }

  /// Загружает новые посты
  Future<List<ServicePostData>> loadPosts(int start, int count) async {
    await Future.delayed(Duration(seconds: 1));
    return teamLeadService.loadPosts(start, count);
  }

  /// Устанавливает тип вкладки
  @action
  void setTab(PostTabType tabType) {
    this.tabType = tabType;
    switch (tabType) {
      case PostTabType.All:
        if (teamLeadAppStore.postListPageStore.allPosts.length < 1) {
          teamLeadAppStore.postListPageStore.loadMore();
        }
        break;
      case PostTabType.Featured:
        break;
      case PostTabType.My:
        break;
    }
  }
}

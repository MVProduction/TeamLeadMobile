import 'package:mobx/mobx.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_list/stores/favorite_post_list_store.dart';
import 'package:team_lead/pages/post_list/stores/main_post_list_store.dart';
import 'package:team_lead/pages/post_list/stores/post_tab_type.dart';
import 'package:team_lead/pages/post_list/stores/user_post_list_store.dart';

part 'post_list_page_store.g.dart';

class PostListPageStore = _PostListPageStore with _$PostListPageStore;

/// Состояние страницы постов
abstract class _PostListPageStore with Store {
  /// Тип вкладки
  @observable
  PostTabType tabType = PostTabType.All;

  /// Заголовок страницы
  @observable
  String pageTitle = "Все объявления";

  /// Необходимо отображать панель поиска
  @observable
  bool needShowSearchPanel = false;

  /// Необходимо отображать кнопку поиска
  @observable
  bool needShowSearchButton = true;

  /// Состояние основного списка постов
  MainPostListStore mainPostListStore = MainPostListStore();

  /// Состояние списка избранных постов
  FavoritePostListStore favoritePostListStore = FavoritePostListStore();

  /// Состояние списка постов пользователя
  UserPostListStore userPostListStore = UserPostListStore();

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

  /// Устанавливает тип вкладки
  @action
  void setTab(PostTabType tabType) {
    this.tabType = tabType;
    switch (tabType) {
      case PostTabType.All:
        pageTitle = "Все объявления";
        teamLeadAppStore.postListPageStore.mainPostListStore.fetchPosts();
        break;
      case PostTabType.Favorite:
        pageTitle = "Избранные объявления";
        teamLeadAppStore.postListPageStore.favoritePostListStore.fetchPosts();
        break;
      case PostTabType.My:
        pageTitle = "Мои объявления";
        teamLeadAppStore.postListPageStore.userPostListStore.fetchPosts();
        break;
    }
  }
}

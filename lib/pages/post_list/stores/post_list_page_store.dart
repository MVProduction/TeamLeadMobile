import 'package:mobx/mobx.dart';
import 'package:team_lead/pages/post_list/stores/post_tab_type.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_service.dart';

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
  ObservableList<ServicePostData> posts = ObservableList.of([]);

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

  /// Добавляет пост
  @action
  void addPost(ServicePostData post) {
    posts.add(post);
  }

  /// Устанавливает посты
  @action
  void setPosts(List<ServicePostData> posts) {
    this.posts.clear();
    this.posts.addAll(posts);
  }

  /// Устанавливает тип вкладки
  @action
  void setTab(PostTabType tabType) {
    switch (tabType) {
      case PostTabType.All:
        teamLeadService.loadPosts().then((value) {
          this.tabType = tabType;
          setPosts(value);
        });
        break;
      case PostTabType.Featured:
        setPosts([]);
        break;
      case PostTabType.My:
        setPosts([]);
        break;
    }
  }
}

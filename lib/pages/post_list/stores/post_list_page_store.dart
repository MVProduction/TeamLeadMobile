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

  /// Добавляет пост
  @action
  void addPosts(List<ServicePostData> posts) {
    this.posts.addAll(posts);
  }

  /// Устанавливает посты
  @action
  void setPosts(List<ServicePostData> posts) {
    this.posts.clear();
    this.posts.addAll(posts);
  }

  /// Загружает ещё посты и добавляет в список
  Future loadMore() async {
    final newPosts = await loadPosts(posts.length, 3);
    addPosts(newPosts);
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
        if (teamLeadAppStore.postListPageStore.posts.length < 1) {
          teamLeadAppStore.postListPageStore.loadMore();
        } else {
          setPosts([]);
        }
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

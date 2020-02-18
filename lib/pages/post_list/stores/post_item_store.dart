import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';

part 'post_item_store.g.dart';

class PostItemStore = _PostItemStore with _$PostItemStore;

/// Состояние элемента списка
abstract class _PostItemStore with Store {
  /// Пост
  final ServicePostData post;

  /// Для отображения процесса добавления в избранное
  @observable
  ObservableFuture<bool> isFavorite;

  /// Конструктор
  _PostItemStore(this.post) {
    isFavorite = ObservableFuture.value(post.isFavorite);
  }

  /// Добавляет в избранное
  @action
  Future addToFavorite() {
    isFavorite = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      await teamLeadService.postService.addPostToFavorite(post.id);
      return true;
    }));

    return isFavorite;
  }

  /// Убирает из избранного
  @action
  Future removeFavorite() {
    isFavorite = ObservableFuture(Future(() async {
      await Future.delayed(Duration(seconds: 2));
      await teamLeadService.postService.removePostFromFavorite(post.id);
      teamLeadAppStore.postListPageStore.favoritePostListStore
          .removePost(post.id);
      return false;
    }));

    return isFavorite;
  }
}

import 'package:mobx/mobx.dart';
import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';

part 'post_item_store.g.dart';

class PostItemStore = _PostItemStore with _$PostItemStore;

/// Состояние элемента списка
abstract class _PostItemStore with Store {
  /// Пост
  final PostWithUserData post;

  /// Для отображения процесса добавления в избранное
  @observable
  ObservableFuture<bool> isFavorite;

  /// Конструктор
  _PostItemStore(this.post) {
    isFavorite = ObservableFuture.value(post.postIsFavorite);
  }

  /// Добавляет в избранное
  @action
  Future addToFavorite() {
    isFavorite = ObservableFuture(Future(() async {
      await teamLeadService.postService.addPostToFavorite(post.postId);
      return true;
    }));

    return isFavorite;
  }

  /// Убирает из избранного
  @action
  Future removeFavorite() {
    isFavorite = ObservableFuture(Future(() async {
      await teamLeadService.postService.removePostFromFavorite(post.postId);
      teamLeadAppStore.postListPageStore.favoritePostListStore
          .removePost(post.postId);
      return false;
    }));

    return isFavorite;
  }
}

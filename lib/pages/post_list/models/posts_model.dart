import 'package:flutter/foundation.dart';
import 'package:team_lead/pages/post_list/models/post_list_item_data.dart';
import 'package:team_lead/services/team_lead_service.dart';

/// Модель для постов
class PostsModel extends ChangeNotifier {
  /// Посты
  List<PostListItemData> posts = [];

  /// Устанавливает посты
  void setPosts(List<PostListItemData> posts) {
    this.posts = posts;
    notifyListeners();
  }

  PostsModel() {
    TeamLeadService().loadPosts().then((res) {
      setPosts(res
          .map((x) => PostListItemData.fromServicePostListItemData(x))
          .toList());
    });
  }
}

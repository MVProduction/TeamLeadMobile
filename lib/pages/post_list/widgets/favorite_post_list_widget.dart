import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/pages/post_list/widgets/post_item_widget.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/team_lead_app_store.dart';

/// Список избранных постов
class FavoritePostListWidget extends StatelessWidget {
  /// Обрабатывает нажатие на пост
  void _onPostClick(BuildContext context, ServicePostData post) {
    Navigator.pushNamed(context, Routes.DiscussPost, arguments: post);
  }

  /// Обрабатывает нажатие кнопки избранное
  void _onFavoriteClick(BuildContext context, ServicePostData post) {}

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final future =
          teamLeadAppStore.postListPageStore.favoritePostListStore.allPosts;

      switch (future.status) {
        case FutureStatus.fulfilled:
          return ListView.builder(itemBuilder: (context, index) {
            final values = future.value;
            if (index >= values.length) return null;
            final post = values[index];
            return PostItemWidget(post, (p) => _onPostClick(context, p),
                (p) => _onFavoriteClick(context, p));
          });
          break;
        default:
          return Center(
            child: CircularProgressIndicator(),
          );
          break;
      }
    });
  }
}

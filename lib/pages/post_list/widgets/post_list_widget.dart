import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:team_lead/pages/post_list/widgets/post_item_widget.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/team_lead_app_store.dart';

/// Элемент поста
class PostListWidget extends StatelessWidget {
  final _controller = RefreshController();

  /// Обрабатывает нажатие на пост
  void _onPostClick(BuildContext context, ServicePostData post) {
    Navigator.pushNamed(context, Routes.DiscussPost, arguments: post);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        footer: ClassicFooter(),
        controller: _controller,
        child: ListView.builder(itemBuilder: (context, index) {
          if (index >= teamLeadAppStore.postListPageStore.posts.length)
            return null;
          final post = teamLeadAppStore.postListPageStore.posts[index];
          return PostItemWidget(post, (p) => _onPostClick(context, p));
        }));
  }
}

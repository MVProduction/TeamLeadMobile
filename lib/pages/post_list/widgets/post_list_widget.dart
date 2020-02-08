import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_lead/pages/post_list/widgets/post_item_widget.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/team_lead_app_store.dart';

/// Элемент поста
class PostListWidget extends StatelessWidget {
  /// Обрабатывает нажатие на пост
  void _onPostClick(BuildContext context, ServicePostData post) {
    Navigator.pushNamed(context, Routes.DiscussPost, arguments: post);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: <Widget>[
            Flexible(
                flex: 1,
                child: ListView(
                    children: teamLeadAppStore.postListPageStore.posts
                        .map((x) =>
                            PostItemWidget(x, (p) => _onPostClick(context, p)))
                        .toList()))
          ],
        );
      },
    );
  }
}

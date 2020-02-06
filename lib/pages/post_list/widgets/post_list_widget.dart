import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:team_lead/models/posts/post_list_item_data.dart';
import 'package:team_lead/models/posts/posts_model.dart';
import 'package:team_lead/pages/post_list/widgets/post_item_widget.dart';
import 'package:team_lead/routes.dart';

/// Элемент поста
class PostListWidget extends StatelessWidget {
  /// Обрабатывает нажатие на пост
  void _onPostClick(BuildContext context, PostListItemData post) {
    Navigator.pushNamed(context, Routes.DiscussPost, arguments: post);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Consumer<PostsModel>(
      builder: (context, postsModel, child) {
        return Column(
          children: <Widget>[
            Flexible(
                flex: 1,
                child: ListView(
                    children: postsModel.posts
                        .map((x) =>
                            PostItemWidget(x, (p) => _onPostClick(context, p)))
                        .toList()))
          ],
        );
      },
    );
  }
}

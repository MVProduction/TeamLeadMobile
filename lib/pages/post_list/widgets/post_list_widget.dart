import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:team_lead/pages/post_list/models/posts_model.dart';
import 'package:team_lead/pages/post_list/widgets/post_item_widget.dart';

/// Элемент поста
class PostListWidget extends StatelessWidget {
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
                        .map((x) => PostItemWidget(x))
                        .toList()))
          ],
        );
      },
    );
  }
}

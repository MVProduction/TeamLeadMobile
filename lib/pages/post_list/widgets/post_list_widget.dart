import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:team_lead/pages/post_list/stores/post_tab_type.dart';
import 'package:team_lead/pages/post_list/widgets/post_item_widget.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/team_lead_app_store.dart';

/// Состояние списка
class PostListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostListWidgetState();
}

/// Состояние списка
class _PostListWidgetState extends State<PostListWidget> {
  /// Контроллер обновления
  final _controller = RefreshController();

  /// Обрабатывает нажатие на пост
  void _onPostClick(BuildContext context, ServicePostData post) {
    Navigator.pushNamed(context, Routes.DiscussPost, arguments: post);
  }

  /// Обрабатывает нажатие кнопки избранное
  void _onFavoriteClick(BuildContext context, ServicePostData post) {
    setState(() {
      post.isFavorite = !post.isFavorite;
    });
  }

  /// Загружает ещё посты
  void _onLoading() async {
    await teamLeadAppStore.postListPageStore.loadMore();
    setState(() {});
    _controller.loadComplete();
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        switch (teamLeadAppStore.postListPageStore.tabType) {
          case PostTabType.All:
            return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                footer: ClassicFooter(),
                controller: _controller,
                onLoading: _onLoading,
                child: ListView.builder(itemBuilder: (context, index) {
                  if (index >=
                      teamLeadAppStore.postListPageStore.allPosts.length)
                    return null;
                  final post =
                      teamLeadAppStore.postListPageStore.allPosts[index];
                  return PostItemWidget(post, (p) => _onPostClick(context, p),
                      (p) => _onFavoriteClick(context, p));
                }));
          default:
            break;
        }

        return ListView();
      },
    );
  }
}

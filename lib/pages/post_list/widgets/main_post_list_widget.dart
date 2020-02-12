import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:team_lead/pages/post_list/widgets/post_item_widget.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/team_lead_app_store.dart';

/// Список со всеми постами
class MainPostListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPostListWidgetState();
}

/// Состояние списка
class _MainPostListWidgetState extends State<MainPostListWidget> {
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
    await teamLeadAppStore.postListPageStore.mainPostListStore.fetchOld();
    setState(() {});
    _controller.loadComplete();
  }

  /// Обновляет посты
  void _onRefresh() async {
    await teamLeadAppStore.postListPageStore.mainPostListStore.fetchPosts();
    setState(() {});
    _controller.refreshCompleted();
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final future =
          teamLeadAppStore.postListPageStore.mainPostListStore.allPosts;

      switch (future.status) {
        case FutureStatus.fulfilled:
          return SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(),
              footer: ClassicFooter(),
              controller: _controller,
              onLoading: _onLoading,
              onRefresh: _onRefresh,
              child: ListView.builder(itemBuilder: (context, index) {
                final values = future.value;
                if (index >= values.length) return null;
                final post = values[index];
                return PostItemWidget(post, (p) => _onPostClick(context, p),
                    (p) => _onFavoriteClick(context, p));
              }));
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

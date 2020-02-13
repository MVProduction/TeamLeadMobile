import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:team_lead/pages/post_list/stores/post_item_store.dart';
import 'package:team_lead/pages/post_list/widgets/post_item_widget.dart';
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
                return PostItemWidget(PostItemStore(post));
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

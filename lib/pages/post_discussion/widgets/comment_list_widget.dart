import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_discussion/widgets/comment_item_widget.dart';

/// Список комментариев
class CommentListWidget extends StatefulWidget {
  /// Создаёт состояние
  @override
  State<StatefulWidget> createState() => CommentListWidgetState();
}

/// Состояние списка
class CommentListWidgetState extends State<CommentListWidget> {
  /// Контроллер обновления
  final _controller = RefreshController();

  /// Загружает ещё посты
  void _onLoading() async {
    await teamLeadAppStore.postDiscussionPageStore.fetchOldComments();
    setState(() {});
    _controller.loadComplete();
  }

  /// Обновляет посты
  void _onRefresh() async {
    await teamLeadAppStore.postDiscussionPageStore.fetchComments();
    setState(() {});
    _controller.refreshCompleted();
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (ctx) {
      final future = teamLeadAppStore.postDiscussionPageStore.comments;

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
                return CommentItemWidget(post);
              }));
        default:
          break;
      }

      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_discussion/widgets/comment_item_widget.dart';

/// Список комментариев
class CommentListWidget extends StatefulWidget {
  /// Идентификатор объявления
  final int postId;

  /// Конструктор
  CommentListWidget(this.postId);

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
    await teamLeadAppStore.postDiscussionPageStore
        .fetchOldComments(widget.postId);
    setState(() {});
    _controller.loadComplete();
  }

  /// Обновляет посты
  void _onRefresh() async {
    await teamLeadAppStore.postDiscussionPageStore.fetchComments(widget.postId);
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
          final values = future.value;

          if (values.isNotEmpty) {
            return SmartRefresher(
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                footer: ClassicFooter(
                    loadingText: "Загружается",
                    canLoadingText: "Нужно больше комментариев"),
                controller: _controller,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                child: ListView.builder(itemBuilder: (context, index) {
                  if (index >= values.length) return null;
                  final post = values[index];
                  return CommentItemWidget(post);
                }));
          }

          return Center(child: Text("Добавьте комментарий"));
        default:
          break;
      }

      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}

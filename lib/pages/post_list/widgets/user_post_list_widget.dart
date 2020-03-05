import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_list/stores/post_item_store.dart';
import 'package:team_lead/pages/post_list/widgets/post_item_widget.dart';

/// Список постов пользователя
class UserPostListWidget extends StatelessWidget {
  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final future =
          teamLeadAppStore.postListPageStore.userPostListStore.allPosts;

      switch (future.status) {
        case FutureStatus.fulfilled:
          final values = future.value;
          
          if (values.isNotEmpty) {
            return ListView.builder(itemBuilder: (context, index) {
              if (index >= values.length) return null;
              final post = values[index];
              return PostItemWidget(PostItemStore(post));
            });
          }
          
          return Center(child: Text("Добавьте объявление"));
        default:
          return Center(
            child: CircularProgressIndicator(),
          );
          break;
      }
    });
  }
}

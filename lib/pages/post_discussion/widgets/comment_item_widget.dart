import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/common/date_utils.dart';

/// Комментарий
class CommentItemWidget extends StatelessWidget {
  /// Имя пользователя
  final String userName;

  /// Дата комментария
  final DateTime dateTime;

  /// Текст комментария
  final String text;

  /// Конструктор
  CommentItemWidget(this.userName, this.dateTime, this.text);

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          dateTime.toLocalizedDateTimeString(),
          style: TextStyle(color: Colors.grey),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            text,
            style: TextStyle(fontSize: 14),
          ),
        )
      ],
    );
  }
}

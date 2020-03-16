import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/common/date_utils.dart';
import 'package:team_lead/common/models/comment_with_user_data.dart';

/// Комментарий
class CommentItemWidget extends StatelessWidget {
  /// Данные комментариям
  final CommentWithUserData comment;

  /// Конструктор
  CommentItemWidget(this.comment);

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    Widget photo;
    if (comment.userPhoto != null) {
      photo = Image.file(comment.userPhoto);
    } else {
      photo = Icon(Icons.supervised_user_circle);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 68,
          child: CircleAvatar(
            radius: 20,
            child: ClipOval(
              child: photo,
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(comment.userName,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                comment.commentDateTime
                    .toLocalizedDateTimeStringFromDate(DateTime.now()),
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 16),
                child: Text(
                  comment.commentText,
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

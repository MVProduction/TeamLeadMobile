import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/common/date_utils.dart';
import 'package:team_lead/common/services/contracts/service_comment_data.dart';

/// Комментарий
class CommentItemWidget extends StatelessWidget {
  /// Данные комментариям
  final ServiceCommentData comment;

  /// Конструктор
  CommentItemWidget(this.comment);

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 68,
          child: CircleAvatar(
            radius: 20,
            child: ClipOval(
              child: Image(image: AssetImage("assets/dummy_face.jpg")),
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
                comment.dateTime
                    .toLocalizedDateTimeStringFromDate(DateTime.now()),
                style: TextStyle(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 16),
                child: Text(
                  comment.text,
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

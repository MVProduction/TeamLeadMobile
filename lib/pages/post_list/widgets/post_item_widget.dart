import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/pages/post_list/models/post_list_item_data.dart';

/// Элемент поста
class PostItemWidget extends StatelessWidget {
  /// Данные поста
  final PostListItemData post;

  /// Конструктор
  PostItemWidget(this.post);

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 8, top: 8, right: 24, left: 24),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4)),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade300, offset: Offset(2, 2))
                ]),
            height: 180,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: 24),
                          width: 100,
                          child: CircleAvatar(
                            radius: 38,
                            backgroundColor: Colors.red,
                            child:
                                Icon(Icons.mood, size: 40, color: Colors.white),
                          )),
                      Expanded(
                          flex: 9,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8, left: 8, right: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 9,
                                        child: Text(post.title,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.favorite_border),
                                        onPressed: () {},
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text(post.userName,
                                      style: TextStyle(
                                          color: Colors.grey.shade500)),
                                ),
                                Text(post.shortText,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,                                    
                                    )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Container(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: Icon(Icons.remove_red_eye,
                                      size: 16, color: Colors.grey),
                                ),
                                Text(post.viewCount.toString())
                              ],
                            ))
                      ],
                    ))
              ],
            )));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:team_lead/models/posts/post_list_item_data.dart';
import 'package:team_lead/models/posts/posts_model.dart';
import 'package:team_lead/pages/post_discussion/widgets/comment_item_widget.dart';
import 'package:team_lead/utils/date_utils.dart';

/// Страница с логином
class PostDiscussionPage extends StatefulWidget {
  /// Конструктор
  PostDiscussionPage({Key key}) : super(key: key);

  @override
  _PostDiscussionPageState createState() => _PostDiscussionPageState();
}

/// Состояние страницы
class _PostDiscussionPageState extends State<PostDiscussionPage> {
  /// Возвращает комментарии
  Widget getComments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (var i = 0; i < 20; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child:
                CommentItemWidget("Ata $i", DateTime.now(), "Комментарий $i"),
          )
      ],
    );
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context).settings.arguments as PostListItemData;

    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (ctx) => PostsModel())],
        child: Scaffold(
          appBar: AppBar(
              title: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
              ),
              Text(post.title, maxLines: 1, overflow: TextOverflow.ellipsis)
            ],
          )),
          body: ListView(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:4, bottom: 32),
                        child: Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 56,
                            child: ClipOval(
                              child: Image(
                                  image: AssetImage("assets/dummy_face.jpg")),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(post.userName,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(post.createDate.toLocalizedDateString()),
                      ),
                      Text(post.shortText, style: TextStyle(fontSize: 18)),
                      Padding(
                        padding: EdgeInsets.only(top: 42, bottom: 32),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: TextField(
                                maxLines: 4,                                
                                decoration: new InputDecoration(                                  
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    hintMaxLines: 4,
                                    hintText: "Добавить комментарий"),
                              ),
                            ),
                            Container(
                              width: 32,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text("Комментарии (11)",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      getComments()
                    ],
                  )),
            ],
          ),
        ));
  }
}

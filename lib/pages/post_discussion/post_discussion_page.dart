import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:team_lead/pages/post_list/models/post_list_item_data.dart';
import 'package:team_lead/pages/post_list/models/posts_model.dart';
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
                child: Icon(Icons.supervised_user_circle, size: 32),
              ),
              Text(post.title, 
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
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
                        padding: const EdgeInsets.only(bottom: 16),
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
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(post.userName,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(post.createDate.toLocalizedString()),
                      ),
                      Text(post.shortText, style: TextStyle(fontSize: 16)),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.all(16), child: Text("Комментарии (11)"))
            ],
          ),
        ));
  }
}

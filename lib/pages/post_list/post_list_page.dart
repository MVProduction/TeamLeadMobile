import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:team_lead/pages/post_list/models/posts_model.dart';
import 'package:team_lead/pages/post_list/widgets/post_list_widget.dart';

/// Страница с постами поиска команд
class PostListPage extends StatefulWidget {
  /// Конструктор
  PostListPage({Key key}) : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

/// Состояние страницы
class _PostListPageState extends State<PostListPage> {
  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (ctx) => PostsModel())],
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(Icons.supervised_user_circle, size: 32),
                  ),
                  Text("Все посты")
                ],
              ),
              actions: <Widget>[
                IconButton(icon: Icon(Icons.search), onPressed: () {}),
                IconButton(icon: Icon(Icons.layers), onPressed: () {})
              ],
              bottom: TabBar(tabs: [
                Tab(icon: Icon(Icons.sms)),
                Tab(icon: Icon(Icons.favorite)),
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.notifications)),
              ]),
            ),
            body: PostListWidget(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Добавить',
              child: Icon(Icons.add),
            ),
          ),
        ));
  }
}

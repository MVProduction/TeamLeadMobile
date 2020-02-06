import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:team_lead/models/posts/post_tab_type.dart';
import 'package:team_lead/models/posts/posts_model.dart';
import 'package:team_lead/pages/post_list/widgets/post_list_widget.dart';
import 'package:team_lead/routes.dart';

/// Страница с постами поиска команд
class PostListPage extends StatefulWidget {
  /// Конструктор
  PostListPage({Key key}) : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

/// Состояние страницы
class _PostListPageState extends State<PostListPage> {
  /// Обрабатывает нажатие кнопки добавить пост
  void _onPostAddClick() {
    Navigator.pushNamed(context, Routes.CreatePost);
  }

  /// Обрабатывает нажатие кнопки настроек пользователя
  void _onSettingsClick() {
    Navigator.pushNamed(context, Routes.EditUser);
  }

  /// Обрабатывает нажатие на вкладку
  void _onTabClick(int tabIndex) {
    var postsModel = Provider.of<PostsModel>(context, listen: false);
    switch (tabIndex) {
      case 0:
        postsModel.setPostTabType(PostTabType.All);
        break;
      case 1:
        postsModel.setPostTabType(PostTabType.Featured);
        break;
      case 2:
        postsModel.setPostTabType(PostTabType.My);
        break;
    }
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(Icons.supervised_user_circle, size: 32),
              ),
              Consumer<PostsModel>(builder: (context, postsModel, child) {
                switch (postsModel.postTabType) {
                  case PostTabType.All:
                    return Text("Все посты");
                  case PostTabType.Featured:
                    return Text("Избранное");
                  case PostTabType.My:
                    return Text("Мои посты");                  
                }

                return Text("");
              })
            ],
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  _onSettingsClick();
                })
          ],
          bottom: TabBar(onTap: _onTabClick, tabs: [
            Tab(icon: Icon(Icons.sms)),
            Tab(icon: Icon(Icons.favorite)),
            Tab(icon: Icon(Icons.person)),
            //Tab(icon: Icon(Icons.notifications)),
          ]),
        ),
        body: PostListWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _onPostAddClick();
          },
          tooltip: 'Добавить',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:team_lead/models/posts/post_tab_type.dart';
import 'package:team_lead/models/posts/posts_model.dart';
import 'package:team_lead/pages/post_list/widgets/post_list_widget.dart';
import 'package:team_lead/pages/post_list/widgets/search_widget.dart';
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
  /// Признак что нужно отображать панель поиска
  bool _needShowSearchPanel = false;

  /// Признак что нужно отображать кнопку поиска
  bool _needShowSearchButton = true;

  /// Обрабатывает нажатие кнопки добавить пост
  void _onPostAddClick() {
    Navigator.pushNamed(context, Routes.CreatePost);
  }

  /// Обрабатывает нажатие кнопки настроек пользователя
  void _onSettingsClick() {
    Navigator.pushNamed(context, Routes.EditUser);
  }

  /// Обрабатывает нажатие на кнопку поиска
  void _onSearchClick() {
    setState(() {
      _needShowSearchPanel = !_needShowSearchPanel;
    });
  }

  /// Обрабатывает нажатие на вкладку
  void _onTabClick(int tabIndex) {
    setState(() {
      _needShowSearchPanel = false;
    });

    var postsModel = Provider.of<PostsModel>(context, listen: false);
    switch (tabIndex) {
      case 0:
        setState(() {
          _needShowSearchButton = true;
        });
        postsModel.setPostTabType(PostTabType.All);
        break;
      case 1:
        setState(() {
          _needShowSearchButton = false;
        });
        postsModel.setPostTabType(PostTabType.Featured);
        break;
      case 2:
        setState(() {
          _needShowSearchButton = false;
        });
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
            if (_needShowSearchButton)
              if (!_needShowSearchPanel)
                IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _onSearchClick();
                    })
              else
                IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _onSearchClick();
                    }),
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
        body: Column(
          children: <Widget>[
            if (_needShowSearchPanel) SearchWidget(),
            Expanded(flex: 9, child: PostListWidget()),
          ],
        ),
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

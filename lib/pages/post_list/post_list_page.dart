import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_list/stores/post_tab_type.dart';
import 'package:team_lead/pages/post_list/widgets/favorite_post_list_widget.dart';
import 'package:team_lead/pages/post_list/widgets/main_post_list_widget.dart';
import 'package:team_lead/pages/post_list/widgets/search_widget.dart';
import 'package:team_lead/pages/post_list/widgets/user_post_list_widget.dart';
import 'package:team_lead/routes.dart';

/// Страница с постами поиска команд
class PostListPage extends StatefulWidget {
  /// Конструктор
  PostListPage({Key key}) : super(key: key);

  @override
  _PostListPageState createState() => _PostListPageState();
}

/// Состояние страницы
class _PostListPageState extends State<PostListPage>
    with SingleTickerProviderStateMixin {
  /// Страницы
  final _tabs = [
    Tab(icon: Icon(Icons.sms)),
    Tab(icon: Icon(Icons.favorite)),
    Tab(icon: Icon(Icons.person)),
  ];

  /// Контроллер страниц
  TabController _tabController;

  /// Обрабатывает нажатие кнопки добавить пост
  void _onPostAddClick() {
    Navigator.pushNamed(context, Routes.CreatePost).then((value) {
      if (value == "my") {
        teamLeadAppStore.postListPageStore.setTab(PostTabType.My);
      } else {
        teamLeadAppStore.postListPageStore.mainPostListStore.fetchPosts();
      }
    });
  }

  /// Обрабатывает нажатие кнопки настроек пользователя
  void _onSettingsClick() {
    Navigator.pushNamed(context, Routes.EditUser).then((value) {
      teamLeadAppStore.postListPageStore.mainPostListStore.fetchPosts();
    });
  }

  /// Обрабатывает нажатие на кнопку поиска
  void _onSearchClick() {
    teamLeadAppStore.postListPageStore.setNeedShowSearchPanel(
        !teamLeadAppStore.postListPageStore.needShowSearchPanel);
  }

  /// Обрабатывает нажатие на вкладку
  void _onTabClick(int tabIndex) {
    teamLeadAppStore.postListPageStore.setNeedShowSearchPanel(false);

    switch (tabIndex) {
      case 0:
        teamLeadAppStore.postListPageStore.setNeedShowSearchButton(true);
        teamLeadAppStore.postListPageStore.setTab(PostTabType.All);
        break;
      case 1:
        teamLeadAppStore.postListPageStore.setNeedShowSearchButton(false);
        teamLeadAppStore.postListPageStore.setTab(PostTabType.Favorite);
        break;
      case 2:
        teamLeadAppStore.postListPageStore.setNeedShowSearchButton(false);
        teamLeadAppStore.postListPageStore.setTab(PostTabType.My);
        break;
    }
  }

  /// Конструктор
  _PostListPageState();

  /// Инициализирует состояние
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _tabs.length);
    teamLeadAppStore.postListPageStore.setTab(PostTabType.All);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        _tabController.index = teamLeadAppStore.postListPageStore.tabType.index;
        return DefaultTabController(
          initialIndex: 0,
          length: _tabs.length,
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
                  Text(teamLeadAppStore.postListPageStore.pageTitle)
                ],
              ),
              actions: <Widget>[
                // if (teamLeadAppStore.postListPageStore.needShowSearchButton)
                //   IconButton(
                //       icon: Icon(Icons.search),
                //       onPressed: () {
                //         _onSearchClick();
                //       }),
                IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      _onSettingsClick();
                    })
              ],
              bottom: TabBar(
                  controller: _tabController,
                  onTap: (ti) => _onTabClick(ti),
                  tabs: _tabs),
            ),
            body: Column(
              children: <Widget>[
                if (teamLeadAppStore.postListPageStore.needShowSearchPanel)
                  SearchWidget(),
                Expanded(
                    flex: 9,
                    child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          MainPostListWidget(),
                          FavoritePostListWidget(),
                          UserPostListWidget()
                        ]))
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
      },
    );
  }
}

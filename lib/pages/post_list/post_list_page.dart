import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_lead/pages/post_list/stores/post_tab_type.dart';
import 'package:team_lead/pages/post_list/widgets/post_list_widget.dart';
import 'package:team_lead/pages/post_list/widgets/search_widget.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/team_lead_app_store.dart';

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
              Observer(builder: (_) {
                switch (teamLeadAppStore.postListPageStore.tabType) {
                  case PostTabType.All:
                    return Text("Все посты");
                  case PostTabType.Favorite:
                    return Text("Избранное");
                  case PostTabType.My:
                    return Text("Мои посты");
                }

                return Text("");
              })
            ],
          ),
          actions: <Widget>[
            Observer(builder: (context) {
              if (teamLeadAppStore.postListPageStore.needShowSearchButton) {
                return IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _onSearchClick();
                    });
              }

              return Row();
            }),
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  _onSettingsClick();
                })
          ],
          bottom: TabBar(onTap: (ti) => _onTabClick(ti), tabs: [
            Tab(icon: Icon(Icons.sms)),
            Tab(icon: Icon(Icons.favorite)),
            Tab(icon: Icon(Icons.person)),
            //Tab(icon: Icon(Icons.notifications)),
          ]),
        ),
        body: Column(
          children: <Widget>[
            Observer(
              builder: (context) {
                if (teamLeadAppStore.postListPageStore.needShowSearchPanel)
                  return SearchWidget();
                return Row();
              },
            ),
            Expanded(flex: 9, child: 
            FutureBuilder(
              future: teamLeadAppStore.postListPageStore.loadMore(),
              builder: (context, snapshot) {
              return PostListWidget();
            }))            
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

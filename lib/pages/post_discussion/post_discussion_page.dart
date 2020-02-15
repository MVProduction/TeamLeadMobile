import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/pages/post_discussion/widgets/comment_item_widget.dart';
import 'package:team_lead/common/date_utils.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/team_lead_app_store.dart';

/// Страница с логином
class PostDiscussionPage extends StatefulWidget {
  /// Конструктор
  PostDiscussionPage({Key key}) : super(key: key);

  @override
  _PostDiscussionPageState createState() => _PostDiscussionPageState();
}

/// Состояние страницы
class _PostDiscussionPageState extends State<PostDiscussionPage> {
  /// Возвращает вид с заголовком и заданным телом без вкладок
  Widget getScafoldView(String title, Widget body) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8),
          ),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis)
        ],
      )),
      body: body,
    );
  }

  /// Возвращает вид с заголовком и заданным телом с владками
  Widget getScafoldViewWithTabs(String title, Widget body) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                ),
                Text(title, maxLines: 1, overflow: TextOverflow.ellipsis)
              ],
            )),
            body: body,
            bottomNavigationBar: new TabBar(
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(color: Colors.indigo),
                tabs: [
                  Tab(
                    child: Container(child: Text("Пост")),
                    icon: new Icon(Icons.local_post_office),
                  ),
                  Tab(
                    child: Text("Комментарии"),
                    icon: new Icon(Icons.message),
                  )
                ])));
  }

  /// Возвращает вид с постом
  Widget getPostView(ServicePostData post) {
    return ListView(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 32),
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 56,
                        child: ClipOval(
                          child:
                              Image(image: AssetImage("assets/dummy_face.jpg")),
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
                  Text(post.shortText, style: TextStyle(fontSize: 18))
                ])),
      ],
    );
  }

  /// Возвращает вид с комментариями
  Widget getCommentView(ServicePostData post) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: ListView(children: <Widget>[
              for (var i = 0; i < 20; i++)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CommentItemWidget(
                      "Ata $i", DateTime.now(), "Комментарий $i"),
                )
            ]),
          ),
        ),
        Container(
          height: 70,
          color: Colors.grey.shade100,
          padding: EdgeInsets.only(left: 8, top: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  flex: 9,
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: "Введите комментарий"),
                  )),
              Container(
                  width: 40,
                  child: IconButton(
                      icon: Icon(Icons.send, color: Colors.indigo),
                      onPressed: () {}))
            ],
          ),
        )
      ],
    );
  }

  /// Возвращает основной вид с постами и комментариями
  Widget getMainView(ServicePostData post) {
    return TabBarView(children: <Widget>[
      getPostView(post),
      getCommentView(post),
    ]);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    final postId = (ModalRoute.of(context).settings.arguments as int) ?? 1;
    teamLeadAppStore.postDiscussionPageStore.fetchPost(postId);
    return Observer(builder: (context) {
      final future = teamLeadAppStore.postDiscussionPageStore.post;

      switch (future.status) {
        case FutureStatus.fulfilled:
          final post = future.value;
          if (post == null) return Text('NO DATA');

          return getScafoldViewWithTabs(
            post.title,
            getMainView(post),
          );
        default:
          return getScafoldView(
              'Загружается', Center(child: CircularProgressIndicator()));
      }
    });
  }
}

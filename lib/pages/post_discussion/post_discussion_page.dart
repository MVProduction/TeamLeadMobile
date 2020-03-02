import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_discussion/stores/post_with_user_data.dart';
import 'package:team_lead/common/date_utils.dart';
import 'package:team_lead/pages/post_discussion/widgets/comment_list_widget.dart';
import 'package:team_lead/routes.dart';

/// Опции редактирования
class EditOptions {
  /// Можно редактировать
  final bool canEdit;

  /// Идентификатор поста
  final int postId;

  /// Конструктор
  EditOptions(this.canEdit, this.postId);
}

/// Страница с логином
class PostDiscussionPage extends StatefulWidget {
  /// Конструктор
  PostDiscussionPage({Key key}) : super(key: key);

  @override
  _PostDiscussionPageState createState() => _PostDiscussionPageState();
}

/// Состояние страницы
class _PostDiscussionPageState extends State<PostDiscussionPage> {
  /// Контроллер текста ввода комментария
  TextEditingController _commentTextController = TextEditingController();

  /// Обрабатывает изменение вкладки
  void _onTabChange(int tabIndex) {
    switch (tabIndex) {
      case 0:
        teamLeadAppStore.postDiscussionPageStore.fetchPost();
        break;
      case 1:
        teamLeadAppStore.postDiscussionPageStore.fetchComments();
        break;
    }
  }

  /// Обрабатывает нажатие кнопки редактирования
  void _onEditClick(int postId) {
    Navigator.pushNamed(context, Routes.EditPost, arguments: postId)
        .then((value) {
      teamLeadAppStore.postDiscussionPageStore.fetchPost();
    });
  }

  /// Обрабатывает отправку комментария
  void _onCommentSend() {
    final text = _commentTextController.text;
    if (text.isEmpty) return;
    teamLeadAppStore.postDiscussionPageStore.sendComment(text);
    _commentTextController.text = "";
  }

  /// Возвращает вид с заголовком и заданным телом с владками
  Widget getScafoldViewWithTabs(
      String title, EditOptions editOptions, Widget body) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: Text(title, overflow: TextOverflow.ellipsis),
                actions: <Widget>[
                  if (editOptions?.canEdit == true)
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _onEditClick(editOptions.postId))
                ]),
            body: body,
            bottomNavigationBar: new TabBar(
                onTap: _onTabChange,
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
  Widget getPostView(PostWithUserData post) {
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
                    child: Text(post.post.userName,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(post.post.createDate.toLocalizedDateString()),
                  ),
                  if (post.user != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(post.user.contacts),
                    ),
                  Text(post.post.text, style: TextStyle(fontSize: 18))
                ])),
      ],
    );
  }

  /// Возвращает вид с комментариями
  Widget getCommentView(PostWithUserData post) {
    return Column(
      children: [
        Expanded(
          flex: 9,
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 8, right: 8),
            child: CommentListWidget(),
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
                    controller: _commentTextController,
                    decoration:
                        InputDecoration(hintText: "Введите комментарий"),
                  )),
              Container(
                  width: 40,
                  child: IconButton(
                      icon: Icon(Icons.send, color: Colors.indigo),
                      onPressed: _onCommentSend))
            ],
          ),
        )
      ],
    );
  }

  /// Возвращает основной вид с постами и комментариями
  Widget getMainView(PostWithUserData post) {
    return TabBarView(children: <Widget>[
      getPostView(post),
      getCommentView(post),
    ]);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context).settings.arguments as int;

    teamLeadAppStore.postDiscussionPageStore.setPostId(postId);
    teamLeadAppStore.postDiscussionPageStore.fetchPost();
    return Observer(builder: (context) {
      final future = teamLeadAppStore.postDiscussionPageStore.post;

      switch (future.status) {
        case FutureStatus.fulfilled:
          final post = future.value;
          if (post == null) return Text('NO DATA');
          final user = teamLeadAppStore.usersStore.getLoginUser();
          EditOptions editOptions;

          if (post.user != null && user.name == post.user.name) {
            editOptions = EditOptions(true, post.post.id);
          }

          return getScafoldViewWithTabs(
            post.post.title,
            editOptions,
            getMainView(post),
          );
        default:
          return getScafoldViewWithTabs(
              'Загружается', null, Center(child: CircularProgressIndicator()));
      }
    });
  }
}

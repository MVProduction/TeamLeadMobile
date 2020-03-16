import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
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

  /// Идентификатор объявления
  int _postId = -1;

  /// Обрабатывает изменение вкладки
  void _onTabChange(int tabIndex) {
    switch (tabIndex) {
      case 0:
        teamLeadAppStore.postDiscussionPageStore.needShowEdit = true;
        teamLeadAppStore.postDiscussionPageStore.fetchPost(_postId);
        break;
      case 1:
        teamLeadAppStore.postDiscussionPageStore.needShowEdit = false;
        teamLeadAppStore.postDiscussionPageStore.fetchComments(_postId);
        break;
    }
  }

  /// Обрабатывает нажатие кнопки редактирования
  void _onEditClick(int postId) {
    Navigator.pushNamed(context, Routes.EditPost, arguments: postId)
        .then((value) {
      teamLeadAppStore.postDiscussionPageStore.fetchPost(_postId);
    });
  }

  /// Обрабатывает отправку комментария
  void _onCommentSend() {
    final text = _commentTextController.text;
    if (text.isEmpty) return;
    teamLeadAppStore.postDiscussionPageStore.sendComment(_postId, text);
    _commentTextController.text = "";
  }

  /// Возвращает вид с заголовком и заданным телом с владками
  Widget getScafoldViewWithTabs(String title, Widget body,
      {EditOptions editOptions, bool isLoading}) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                title: Text(title, overflow: TextOverflow.ellipsis),
                actions: <Widget>[
                  if (editOptions?.canEdit == true &&
                      teamLeadAppStore.postDiscussionPageStore.needShowEdit)
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
                  if (isLoading == true)
                    Tab(
                      child: Text("Комментарии"),
                      icon: new Icon(Icons.message),
                    )
                  else
                    Tab(
                      child: Observer(builder: (context) {
                        final commentCount = teamLeadAppStore
                            .postDiscussionPageStore.commentCount;
                        return Text("Комментарии ($commentCount)");
                      }),
                      icon: new Icon(Icons.message),
                    )
                ])));
  }

  /// Возвращает вид с постом
  Widget getPostView(PostWithUserData post) {
    Widget photo;

    if (post.userPhoto != null) {
      photo = Image.file(post.userPhoto);
    } else {
      photo = Padding(padding: EdgeInsets.all(4), child: Text("Нет фото"));
    }

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
                          child: photo,
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
                    child:
                        Text(post.postCreateDate.toLocalizedDateTimeString()),
                  ),
                  if (post.userContacts != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(post.userContacts),
                    ),
                  if (post.userSkills?.isNotEmpty == true)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(post.userSkills),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                  ),
                  Text(post.postText, style: TextStyle(fontSize: 18))
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
            child: CommentListWidget(_postId),
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
    _postId = postId;

    teamLeadAppStore.postDiscussionPageStore.fetchPost(_postId);
    return Observer(builder: (context) {
      final future = teamLeadAppStore.postDiscussionPageStore.post;

      switch (future.status) {
        case FutureStatus.fulfilled:
          final post = future.value;
          if (post == null) return Text('NO DATA');
          final user = teamLeadService.userService.getLoginUser();
          EditOptions editOptions;

          if (user.name == post.userName) {
            editOptions = EditOptions(true, post.postId);
          }

          return getScafoldViewWithTabs(post.postTitle, getMainView(post),
              editOptions: editOptions);
        default:
          return getScafoldViewWithTabs(
              'Загружается', Center(child: CircularProgressIndicator()),
              isLoading: true);
      }
    });
  }
}

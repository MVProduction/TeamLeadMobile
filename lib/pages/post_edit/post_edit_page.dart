import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_edit/stores/post_edit_state_type.dart';

/// Страница с редактированием поста
class PostEditPage extends StatefulWidget {
  /// Конструктор
  PostEditPage({Key key}) : super(key: key);

  @override
  _PostEditPageState createState() => _PostEditPageState();
}

/// Состояние страницы
class _PostEditPageState extends State<PostEditPage> {
  /// Констроллер для заголовка
  final _titleController = TextEditingController();

  /// Констроллер для текста поста
  final _textController = TextEditingController();

  /// Обрабатывает нажатие на кнопку сохранение
  void _onCommitClick(int postId) {
    final title = _titleController.text;
    final text = _textController.text;
    if (title.isEmpty || text.isEmpty) return;

    teamLeadAppStore.postEditPageStore.editPost(postId, title, text);
  }

  /// Возвращает вид с заголовками и телом [body]
  Widget getScaffold(String title, Widget body) {
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

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context).settings.arguments as int;
    teamLeadAppStore.postEditPageStore.state = PostEditStateType.Load;

    return Observer(builder: (context) {
      switch (teamLeadAppStore.postEditPageStore.state) {
        case PostEditStateType.Load:
          teamLeadAppStore.postEditPageStore.fetchPost(postId);
          return getScaffold(
              'Идёт загрузка',
              Center(
                child: CircularProgressIndicator(),
              ));
        case PostEditStateType.Edit:
          final post = teamLeadAppStore.postEditPageStore.post;
          _titleController.text = post.title;
          _textController.text = post.text;
          return getScaffold(
            'Редактировать объявление',
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text("Заголовок",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: new InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintMaxLines: 4,
                        hintText: "Введите заголовок"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32, bottom: 16),
                    child: Text("Описание",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                    controller: _textController,
                    maxLines: 10,
                    decoration: new InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        hintMaxLines: 4,
                        hintText: "Введите описание"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Container(
                      height: 48,
                      child: RaisedButton.icon(
                          color: Colors.green.shade700,
                          icon: Icon(Icons.check, color: Colors.white),
                          label: Text('Сохранить',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () => _onCommitClick(postId)),
                    ),
                  )
                ],
              ),
            ),
          );
        case PostEditStateType.PendingSave:
          return getScaffold(
              'Идёт сохранение',
              Center(
                child: CircularProgressIndicator(),
              ));
        case PostEditStateType.Error:
      }

      return Row();
    });
  }
}

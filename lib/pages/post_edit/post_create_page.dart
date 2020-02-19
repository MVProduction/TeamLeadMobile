import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_edit/stores/post_edit_state_type.dart';

/// Страница с созданием поста
class PostCreatePage extends StatefulWidget {
  /// Конструктор
  PostCreatePage({Key key}) : super(key: key);

  @override
  _PostCreatePageState createState() => _PostCreatePageState();
}

/// Состояние страницы
class _PostCreatePageState extends State<PostCreatePage> {
  /// Констроллер для заголовка
  final _titleController = TextEditingController();

  /// Констроллер для текста поста
  final _textController = TextEditingController();

  /// Обрабатывает нажатие на кнопку сохранение
  void _onCommitClick() {
    final title = _titleController.text;
    final text = _textController.text;
    teamLeadAppStore.postCreatePageStore.createPost(title, text);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      final state = teamLeadAppStore.postCreatePageStore.state;
      switch (state) {
        case PostEditStateType.Edit:
          return Scaffold(
            appBar: AppBar(
                title: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                ),
                Text("Создать объявление",
                    maxLines: 1, overflow: TextOverflow.ellipsis)
              ],
            )),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text("Заголовок",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TextField(
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
                          label: Text("Создать",
                              style: TextStyle(color: Colors.white)),
                          onPressed: _onCommitClick),
                    ),
                  )
                ],
              ),
            ),
          );
        case PostEditStateType.PendingSave:
          return Center(
            child: CircularProgressIndicator(),
          );
        case PostEditStateType.Saved:
          return Center(
            child: Text("Сохранено"),
          );
        case PostEditStateType.Error:
          break;
      }

      return Row();
    });
  }
}

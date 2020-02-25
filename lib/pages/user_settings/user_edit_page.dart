import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_page_state_type.dart';

/// Страница редактирования настроек пользователя
class UserEditPage extends StatelessWidget {
  /// Контроллер ввода имени
  final _nameController = TextEditingController();

  /// Контроллер ввода контактной информации
  final _contactController = TextEditingController();

  /// Контроллер ввода навыков
  final _skillController = TextEditingController();

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

  /// Обрабатывает нажатие на кнопку сохранение
  void _onCommitClick() {
    final name = _nameController.text;
    final contact = _contactController.text;

    if (name == null || contact == null) return;
    final skill = _skillController.text;

    teamLeadAppStore.userSettingsPageStore.saveUser(name, contact, skill);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    teamLeadAppStore.userSettingsPageStore.state =
        UserEditPageStateType.Edit;

    final user = teamLeadAppStore.usersStore.getLoginUser();
    _nameController.text = user.name;
    _contactController.text = user.contacts;
    _skillController.text = user.skills;

    return Observer(builder: (context) {
      final state = teamLeadAppStore.userSettingsPageStore.state;
      switch (state) {
        case UserEditPageStateType.Edit:
          return getScaffold(
            'Пользователь',
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  CircleAvatar(
                    radius: 56,
                    child: ClipOval(
                      child: Image(image: AssetImage("assets/dummy_face.jpg")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text("Имя пользователя",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                    controller: _nameController,
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
                        hintText: "Введите имя"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text("Контактная информация",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                    controller: _contactController,
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
                        hintText: "Введите контактную информацию"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: Text("Навыки",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  TextField(
                    controller: _skillController,
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
                        hintText: "Введите Ваши навыки"),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Container(
                        height: 48,
                        child: RaisedButton.icon(
                          color: Colors.green.shade700,
                          icon: Icon(Icons.check, color: Colors.white),
                          label: Text("Сохранить",
                              style: TextStyle(color: Colors.white)),
                          onPressed: _onCommitClick,
                        ),
                      ))
                ],
              ),
            ),
          );
        case UserEditPageStateType.Saving:
          return getScaffold(
              'Идёт сохранение',
              Center(
                child: CircularProgressIndicator(),
              ));
        case UserEditPageStateType.Error:
          break;
      }

      return Row();
    });
  }
}

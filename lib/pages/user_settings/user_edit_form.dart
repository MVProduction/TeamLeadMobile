import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';

/// Функция обрабатывающая изменения данных пользователя
typedef OnUserDataChangeFunc(ServiceUserData user);

/// Форма редактирования пользователя
class UserEditForm extends StatelessWidget {
  /// Пользователь
  final ServiceUserData _editUser;

  /// Контроллер ввода имени
  final _nameController = TextEditingController();

  /// Контроллер ввода контактной информации
  final _contactController = TextEditingController();

  /// Контроллер ввода навыков
  final _skillController = TextEditingController();

  /// Вызывается при изменении данных пользователя
  final OnUserDataChangeFunc _onChange;

  /// Обрабатывает нажатие на кнопку сохранение
  void _onCommitClick() {
    _onChange(ServiceUserData(_editUser.id, _nameController.text,
        _contactController.text, _skillController.text, ""));
  }

  UserEditForm(this._editUser, this._onChange) {
    _nameController.text = _editUser.name;
    _contactController.text = _editUser.contacts;
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
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
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
              ),
              hintMaxLines: 4,
              hintText: "Введите контактную информацию"),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          child: Text("Навыки", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        TextField(
          controller: _skillController,
          decoration: new InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
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
                label: Text("Сохранить", style: TextStyle(color: Colors.white)),
                onPressed: _onCommitClick,
              ),
            ))
      ],
    );
  }
}

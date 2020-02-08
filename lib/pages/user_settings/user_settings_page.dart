import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Страница редактирования настроек пользователя
class UserSettingsPage extends StatelessWidget {
  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              title: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8),
              ),
              Text("Пользователь", maxLines: 1, overflow: TextOverflow.ellipsis)
            ],
          )),
          body: Padding(
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
                  child: Text("Электронная почта",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                TextField(
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
                      hintText: "Введите электронную почту"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: Text("Навыки",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                TextField(
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
                        label: Text("Сохранить",
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {}),
                  ),
                )
              ],
            ),
          ),
        );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void OnTapFunc();

/// Widget для выбора фото: с камеры, с галереи
class ChoosePhotoWidget extends StatelessWidget {
  /// Радиус отображения аватарки
  final double imageRadius;

  /// Радиус кнопки
  final double buttonRadius;

  /// Картинка или иконка
  final Widget image;

  /// Обрабатывает нажатие кнопки
  final OnTapFunc onTap;

  /// Конструктор
  ChoosePhotoWidget(this.onTap,
      {this.image, this.imageRadius = 36, this.buttonRadius = 24});

  /// Создаёт компонент
  @override
  Widget build(BuildContext context) {
    Widget body;
    if (image != null) {
      body = image;
    } else {
      body = Icon(Icons.assignment_ind, size: imageRadius);
    }

    return Stack(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
            radius: imageRadius,
            backgroundColor: Colors.indigo,
            child: ClipOval(child: body)),
      ),
      Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
              onTap: onTap,
              child: CircleAvatar(
                  radius: buttonRadius, child: Icon(Icons.add_a_photo))))
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_lead/widgets/choose_photo_widget/choose_photo_source_type.dart';
import 'package:team_lead/widgets/choose_photo_widget/choose_photo_widget_state_type.dart';
import 'package:team_lead/widgets/choose_photo_widget/choose_photo_widget_store.dart';

typedef void OnChooseSourceTapFunc(ChoosePhotoSourceType sourceType);

/// Widget для выбора фото: с камеры, с галереи
class ChoosePhotoWidget extends StatelessWidget {
  /// Состояние компонента
  final _state = ChoosePhotoWidgetStore();

  /// Радиус отображения аватарки
  final double imageRadius;

  /// Радиус кнопки
  final double buttonRadius;

  /// Картинка или иконка
  final Widget image;

  /// Обрабатывает нажатие кнопки
  final OnChooseSourceTapFunc onTap;

  /// Обрабатывает
  void _onChooseSourceTap() {
    _state.state = ChoosePhotoWidgetStateType.ChooseSource;
  }

  /// Закрывает выбор источника фото
  void _onCloseChooseSource() {
    _state.state = ChoosePhotoWidgetStateType.Init;
  }

  /// Обработка выбора камеры
  void _onCameraTap() {
    onTap(ChoosePhotoSourceType.Camera);
  }

  /// Обработка выбора галереи
  void _onGalleryTap() {
    onTap(ChoosePhotoSourceType.Galery);
  }

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

    return Observer(builder: (context) {
      switch (_state.state) {
        case ChoosePhotoWidgetStateType.Init:
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
                    onTap: _onChooseSourceTap,
                    child: CircleAvatar(
                        radius: buttonRadius, child: Icon(Icons.add_a_photo))))
          ]);
        case ChoosePhotoWidgetStateType.ChooseSource:
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
                    onTap: _onCloseChooseSource,
                    child: CircleAvatar(
                        backgroundColor: Colors.yellow.shade800,
                        radius: buttonRadius,
                        child: Icon(Icons.close)))),
            Positioned(
                bottom: (buttonRadius * 2) + buttonRadius / 2,
                right: 0,
                child: InkWell(
                    onTap: _onCameraTap,
                    child: CircleAvatar(
                        radius: buttonRadius,
                        child: Icon(Icons.center_focus_weak)))),
            Positioned(
                bottom: 0,
                right: (buttonRadius * 2) + buttonRadius / 2,
                child: InkWell(
                    onTap: _onGalleryTap,
                    child: CircleAvatar(
                        radius: buttonRadius, child: Icon(Icons.camera))))
          ]);
      }

      return Row();
    });
  }
}

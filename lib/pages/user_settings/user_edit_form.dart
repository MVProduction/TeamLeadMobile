import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_form_store.dart';
import 'package:team_lead/widgets/choose_photo_widget/choose_photo_source_type.dart';
import 'package:team_lead/widgets/choose_photo_widget/choose_photo_widget.dart';

/// Функция обрабатывающая изменения данных пользователя
typedef OnUserDataChangeFunc(ServiceUserData user);

/// Форма редактирования пользователя
class UserEditForm extends StatelessWidget {
  /// Радиус фотки
  static const double ImageRadius = 68;

  /// Состояние формы
  final UserEditFormStore _formStore;

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
        _contactController.text, _skillController.text, _formStore.photoUrl));
  }

  /// Обрабатывает получение фотки
  Future _onGetImage(ChoosePhotoSourceType source) async {
    ImageSource imageSource = ImageSource.camera;
    if (source == ChoosePhotoSourceType.Galery) {
      imageSource = ImageSource.gallery;
    }

    var imageFile = await ImagePicker.pickImage(
        source: imageSource, maxWidth: 600, maxHeight: 600);

    if (imageFile == null) {
      return;
    }

    final croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Выделение картинки',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Выделение картинки',
        ));

    if (croppedFile != null) {
      final user = teamLeadService.userService.getLoginUser();
      final userId = user.id;
      final photoName = "${userId}_photo";
      _formStore.savePhoto(croppedFile, photoName);
    }
  }

  /// Конструктор
  UserEditForm(this._editUser, this._onChange)
      : _formStore = UserEditFormStore(_editUser.photoUrl) {
    _nameController.text = _editUser.name;
    _contactController.text = _editUser.contacts;

    _formStore.fetchPhoto();
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {    
    return Observer(builder: (context) {
      final photoFuture = _formStore.photoFuture;

      Widget photoWidget;
      switch (photoFuture.status) {
        case FutureStatus.fulfilled:
          final photo = photoFuture.value;
          photoWidget = ChoosePhotoWidget(
            _onGetImage,
            imageRadius: ImageRadius,
            image: photo,
          );
          break;
        default:
          photoWidget = Center(
            child: CircularProgressIndicator(),
          );
          break;
      }

      return ListView(
        children: <Widget>[
          photoWidget,
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
            child:
                Text("Навыки", style: TextStyle(fontWeight: FontWeight.bold)),
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
                  label:
                      Text("Сохранить", style: TextStyle(color: Colors.white)),
                  onPressed: _onCommitClick,
                ),
              ))
        ],
      );
    });
  }
}

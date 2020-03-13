import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/team_lead_service.dart';

part 'user_edit_form_store.g.dart';

class UserEditFormStore = _UserEditFormStore with _$UserEditFormStore;

/// Состояние формы редактирования пользователя
abstract class _UserEditFormStore with Store {
  /// Файл фотки
  File photoFile;

  /// Путь до файла фотки пользователя
  String photoUrl;

  /// Фото пользователя
  @observable
  ObservableFuture<Widget> photoFuture = ObservableFuture.value(
      Padding(padding: EdgeInsets.all(4), child: Text("Нет фото")));

  /// Конструктор
  _UserEditFormStore(this.photoUrl);

  /// Загружает фото
  @action
  Future fetchPhoto() {
    print("_UserEditFormStore fetchPhoto");
    photoFuture = ObservableFuture(Future(() async {
      print(photoUrl);
      if (photoUrl != null && photoUrl.isNotEmpty) {
        final photoFile =
            await teamLeadService.storageService.loadFile(photoUrl);
        if (photoFile != null) {
          return Image.file(photoFile, fit: BoxFit.cover);
        }
      }

      return Padding(padding: EdgeInsets.all(4), child: Text("Нет фото"));
    }));

    return photoFuture;
  }

  /// Устанавливает фото
  @action
  Future setPhoto(File file) async {
    photoFuture = ObservableFuture.value(Image.file(file, fit: BoxFit.cover));
    photoFile = file;
    return photoFuture;
  }
}

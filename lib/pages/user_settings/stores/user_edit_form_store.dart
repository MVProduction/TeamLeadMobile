import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'user_edit_form_store.g.dart';

class UserEditFormStore = _UserEditFormStore with _$UserEditFormStore;

/// Состояние формы редактирования пользователя
abstract class _UserEditFormStore with Store {
  /// Фото пользователя
  @observable
  Image photoImage = Image(image: AssetImage("assets/dummy_face.jpg"));
}

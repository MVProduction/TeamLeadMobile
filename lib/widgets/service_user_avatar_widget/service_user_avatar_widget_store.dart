import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/widgets/service_user_avatar_widget/service_user_avatar_widget_state_type.dart';

part 'service_user_avatar_widget_store.g.dart';

class ServiceUserAvatarStore = _ServiceUserAvatarStore
    with _$ServiceUserAvatarStore;

/// Состояние компонента выбора фото
abstract class _ServiceUserAvatarStore with Store {
  /// Состояние компонента
  @observable
  ServiceUserAvatarStateType state = ServiceUserAvatarStateType.Load;

  /// Картинка аватара
  @observable
  Widget image;

  /// Загружает картинку
  @action
  Future fetchImage(String photoUrl) async {
    state = ServiceUserAvatarStateType.Load;

    final file = await teamLeadService.storageService.loadFile(photoUrl);
    if (file != null) {
      image = Image.file(file);
    } else {
      image = Text("Нет фото");
    }

    state = ServiceUserAvatarStateType.Show;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_lead/widgets/service_user_avatar_widget/service_user_avatar_widget_state_type.dart';
import 'package:team_lead/widgets/service_user_avatar_widget/service_user_avatar_widget_store.dart';

/// Widget для аватара пользователя, загружаемого с сервиса
class ServiceUserAvatarWidget extends StatelessWidget {
  /// Адрес для скачивания фотки
  final String _photoUrl;

  /// Радиус аватарки
  final double radius;

  /// Состояние компонента
  final _state = ServiceUserAvatarStore();

  /// Конструктор
  ServiceUserAvatarWidget(this._photoUrl, {this.radius = 38}) {
    _state.fetchImage(_photoUrl);
  }

  /// Создаёт widget
  @override
  Widget build(BuildContext context) {
    print("IMAGE BUILD");
    return Observer(builder: (context) {
      switch (_state.state) {
        case ServiceUserAvatarStateType.Load:
          return CircleAvatar(
              radius: radius, child: CircularProgressIndicator());
        case ServiceUserAvatarStateType.Show:
          return CircleAvatar(
              radius: radius,
              backgroundColor: Colors.red,
              child: ClipOval(child: _state.image));
      }

      return Row();
    });
  }
}

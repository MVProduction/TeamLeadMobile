import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/common/services/contracts/auth_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/user_settings/stores/user_create_page_store.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_page_state_type.dart';
import 'package:team_lead/pages/user_settings/user_edit_form.dart';
import 'package:team_lead/routes.dart';

/// Страница создания настроек пользователя
class UserCreatePage extends StatelessWidget {
  /// Состояние страницы
  final _pageStore = UserCreatePageStore();

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

  /// Обрабатывает изменения данных пользователя
  void _onChange(ServiceUserData data, BuildContext context) async {
    _pageStore.createUser(
        data.id, data.name, data.contacts, data.skills, context);
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context).settings.arguments as AuthUserData;

    switch (_pageStore.state) {
      case UserEditPageStateType.Edit:
        return getScaffold(
            "Создание пользователя",
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: UserEditForm(
                  ServiceUserData(
                      user.id, user.name, user.email, "", user.photoUrl),
                  (d) => _onChange(d, context)),
            ));
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
  }
}

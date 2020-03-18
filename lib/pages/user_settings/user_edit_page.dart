import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_form_data.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_page_state_type.dart';
import 'package:team_lead/pages/user_settings/stores/user_edit_page_store.dart';
import 'package:team_lead/pages/user_settings/user_edit_form.dart';

/// Страница редактирования настроек пользователя
class UserEditPage extends StatelessWidget {
  /// Состояние страницы
  final _pageState = UserEditPageStore();

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
  void _onChange(UserEditFormData data, BuildContext context) {
    _pageState.updateUser(data).then((value) {
      Navigator.pop(context);
    });
  }

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    final user = teamLeadService.userService.getLoginUser();

    if (user is ServiceUserData) {
      return Observer(builder: (context) {
        final state = _pageState.state;
        switch (state) {
          case UserEditPageStateType.Edit:
            return getScaffold(
              'Пользователь',
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: UserEditForm(user, (u) => _onChange(u, context)),
              ),
            );
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
      });
    }

    return getScaffold(
        'Анонимный вход',
        Center(
            child: Padding(
          padding: EdgeInsets.all(30),
          child: Text(
            "А если войдёте как нормальный пользователь, здесь будет информация о Вас, которую будут видеть другие пользователи!",
            textAlign: TextAlign.center,
          ),
        )));
  }
}

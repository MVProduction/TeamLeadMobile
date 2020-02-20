import 'package:mobx/mobx.dart';
import 'package:team_lead/common/stores/users_store.dart';
import 'package:team_lead/pages/post_discussion/stores/post_discussion_page_store.dart';
import 'package:team_lead/pages/post_edit/stores/post_create_page_store.dart';
import 'package:team_lead/pages/post_edit/stores/post_edit_page_store.dart';
import 'package:team_lead/pages/post_list/stores/post_list_page_store.dart';
import 'package:team_lead/pages/user_settings/stores/user_settings_page_store.dart';

part 'team_lead_app_store.g.dart';

/// Экземпляр модели приложения
final teamLeadAppStore = TeamLeadAppStore();

class TeamLeadAppStore = _TeamLeadAppStore with _$TeamLeadAppStore;

/// Основаная модель приложения
abstract class _TeamLeadAppStore with Store {
  /// Модель для получения информации пользователей
  final UsersStore usersStore = UsersStore();

  /// Модель для страницы с постами
  final PostListPageStore postListPageStore = PostListPageStore();

  /// Модель страницы обсуждения поста
  final PostDiscussionPageStore postDiscussionPageStore =
      PostDiscussionPageStore();

  /// Модель создания поста
  final PostCreatePageStore postCreatePageStore = PostCreatePageStore();

  /// Модель редактирования поста
  final PostEditPageStore postEditPageStore = PostEditPageStore();

  /// Модель настроек пользователя
  final UserSettingsPageStore userSettingsPageStore = UserSettingsPageStore();
}

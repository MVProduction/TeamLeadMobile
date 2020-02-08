import 'package:mobx/mobx.dart';
import 'package:team_lead/pages/post_list/stores/post_list_page_store.dart';

part 'team_lead_app_store.g.dart';

/// Экземпляр модели приложения
final teamLeadAppStore = TeamLeadAppStore();

class TeamLeadAppStore = _TeamLeadAppStore with _$TeamLeadAppStore;

/// Основаная модель приложения
abstract class _TeamLeadAppStore with Store {
  /// Модель для страницы с постами
  final PostListPageStore postListPageStore = PostListPageStore();
}

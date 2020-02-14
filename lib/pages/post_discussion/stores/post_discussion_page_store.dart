import 'package:mobx/mobx.dart';
import 'package:team_lead/services/contracts/service_post_data.dart';
import 'package:team_lead/services/team_lead_service.dart';
import 'package:team_lead/team_lead_app_store.dart';

part 'post_discussion_page_store.g.dart';

class PostDiscussionPageStore = _PostDiscussionPageStore with _$PostDiscussionPageStore;

/// Состояние страницы обсуджения
abstract class _PostDiscussionPageStore with Store {
  /// Для загрузки поста
  ObservableFuture<ServicePostData> post = ObservableFuture.value(null);
}
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';

/// Данные поста с данными
class PostWithUserData {
  /// Пользователь
  final ServiceUserData user;

  /// Пост
  final ServicePostData post;

  /// Конструктор
  PostWithUserData(this.user, this.post);
}

import 'dart:io';

import 'package:team_lead/common/models/comment_with_user_data.dart';
import 'package:team_lead/common/models/user_with_photo.dart';
import 'package:team_lead/common/services/comment_service.dart';
import 'package:team_lead/common/services/contracts/service_comment_data.dart';
import 'package:team_lead/common/services/storage_service.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Утилита для работы с комментариями
extension CommentServiceHelper on CommentService {
  /// Загружает комментарии с данными пользователя
  Future<List<CommentWithUserData>> loadCommentsWithUserData(
      List<ServiceCommentData> comments,
      UserService userService,
      StorageService storageService) async {
    final userData = <String, UserWithPhoto>{};
    for (var comment in comments) {
      if (comment.userId == null) continue;
      final user = await userService.getUserInfoById(comment.userId);
      if (user == null) continue;
      File photo;
      if (user.photoUrl?.isNotEmpty == true) {
        photo = await storageService.loadFile(user.photoUrl);
      }

      userData[user.id] = UserWithPhoto(user, photo);
    }

    final ncomments = List<CommentWithUserData>();

    for (var x in comments) {
      final data = userData[x.userId];
      if (data == null) continue;
      ncomments.add(CommentWithUserData(
          userId: data.user.id,
          userName: data.user.name,
          userPhotoUrl: data.user.photoUrl,
          userPhoto: data.photo,
          commentId: x.id,
          commentDateTime: x.dateTime,
          commentText: x.text));
    }

    return ncomments;
  }
}

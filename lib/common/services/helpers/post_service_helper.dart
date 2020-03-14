import 'dart:io';

import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/models/user_with_photo.dart';
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/services/post_service.dart';
import 'package:team_lead/common/services/storage_service.dart';
import 'package:team_lead/common/services/user_service.dart';

/// Расширение для PostService
extension PostServiceHelper on PostService {
  /// Загружает объявления с данными пользователя
  Future<List<PostWithUserData>> loadPostsWithUserData(
      List<ServicePostData> posts,
      UserService userService,
      StorageService storageService) async {
    final userData = <String, UserWithPhoto>{};

    for (var post in posts) {
      if (post.userId == null) continue;
      final user = await userService.getUserInfoById(post.userId);
      if (user == null) continue;
      File photo;
      if (user.photoUrl?.isNotEmpty == true) {
        photo = await storageService.loadFile(user.photoUrl);
      }

      userData[user.id] = UserWithPhoto(user, photo);
    }

    final nposts = List<PostWithUserData>();

    for (var x in posts) {
      final data = userData[x.userId];
      if (data == null) continue;
      nposts.add(PostWithUserData(
          userId: data.user.id,
          userName: data.user.name,
          userContacts: data.user.contacts,
          userPhotoUrl: data.user.photoUrl,
          userPhoto: data.photo,
          userSkills: data.user.skills,
          postId: x.id,
          postTitle: x.title,
          postText: x.text,
          postCreateDate: x.createDate,
          postViewCount: x.viewCount,
          postLastCommentId: x.lastCommentId));
    }

    return nposts;
  }
}

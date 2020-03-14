import 'dart:io';

import 'package:flutter/widgets.dart';

/// Данные поста с данными
class PostWithUserData {
  /// Идентификатор
  final String userId;

  /// Имя пользователя
  final String userName;

  /// Электронная почта
  final String userContacts;

  /// Url для фото пользователя
  final String userPhotoUrl;

  /// Url для фото пользователя
  final File userPhoto;

  /// Навыки
  final String userSkills;

  /// Идентификатор поста
  final int postId;

  /// Заголовок
  final String postTitle;

  /// Время создания поста
  final DateTime postCreateDate;

  /// Описание поста
  final String postText;

  /// Количество просмотров
  final int postViewCount;

  /// Последний идентификатор комментария
  final int postLastCommentId;

  /// Добавлено ли в избранное
  bool postIsFavorite;

  /// Конструктор
  PostWithUserData(
      {@required this.userId,
      @required this.userName,
      @required this.userContacts,
      @required this.userPhotoUrl,
      @required this.userPhoto,
      @required this.userSkills,
      @required this.postId,
      @required this.postTitle,
      @required this.postText,
      @required this.postCreateDate,
      @required this.postViewCount,
      @required this.postLastCommentId});
}

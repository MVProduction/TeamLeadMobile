import 'dart:io';

import 'package:flutter/widgets.dart';

/// Комментарий с данными пользователя
class CommentWithUserData {  
  /// Идентификатор
  final String userId;

  /// Имя пользователя
  final String userName;

  /// Url для фото пользователя
  final String userPhotoUrl;

  /// Загруженное фото
  final File userPhoto;

  /// Идентификатор комментария
  final int commentId;

  // Дата и время комментария
  final DateTime commentDateTime;

  /// Текст комментария
  final String commentText;

  /// Конструктор
  CommentWithUserData(
      {@required this.userId,
      @required this.userName,
      @required this.userPhotoUrl,
      @required this.userPhoto,
      @required this.commentId,
      @required this.commentDateTime,
      @required this.commentText});
}

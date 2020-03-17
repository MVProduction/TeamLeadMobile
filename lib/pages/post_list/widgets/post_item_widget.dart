import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/models/post_with_user_data.dart';
import 'package:team_lead/common/services/contracts/service_user_data.dart';
import 'package:team_lead/common/services/team_lead_service.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_list/stores/post_item_store.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/common/date_utils.dart';

/// Элемент поста
class PostItemWidget extends StatelessWidget {
  /// Данные поста
  final PostItemStore postStore;

  /// Пост пользователя
  final PostWithUserData _post;

  /// Обрабатывает нажатие на пост
  void _onPostClick(BuildContext context, PostWithUserData post) {
    Navigator.pushNamed(context, Routes.DiscussPost, arguments: post.postId)
        .then((value) {
      teamLeadAppStore.postListPageStore
          .setTab(teamLeadAppStore.postListPageStore.tabType);
    });
  }

  /// Обрабатывает нажатие удалить из избранного
  void _onRemoveFromFavorite(BuildContext context, PostWithUserData post) {
    postStore.removeFavorite();
  }

  /// Обрабатывает нажатие добавить в избранное
  void _onAddToFavorite(BuildContext context, PostWithUserData post) {
    postStore.addToFavorite();
  }

  /// Конструктор
  PostItemWidget(this._post) : postStore = PostItemStore(_post);

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    final user = teamLeadService.userService.getLoginUser();
    final userId = (user is ServiceUserData) ? user.id : null;

    print("post_item_widget");
    print(_post.userPhoto == null);

    return Padding(
        padding: EdgeInsets.only(bottom: 8, top: 8, right: 16, left: 16),
        child: InkWell(
          onTap: () => _onPostClick(context, _post),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  boxShadow: [
                    BoxShadow(color: Colors.grey.shade300, offset: Offset(2, 2))
                  ]),
              height: 200,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 10,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 24),
                            width: 100,
                            child: CircleAvatar(
                                radius: 38,
                                backgroundColor: Colors.red,
                                child: ClipOval(
                                    child: Image.file(_post.userPhoto)))),
                        Expanded(
                            flex: 9,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, left: 8, right: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 9,
                                          child: Text(_post.postTitle,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                        _post.postCreateDate
                                            .toLocalizedDateTimeStringFromDate(
                                                DateTime.now()),
                                        style: TextStyle(
                                            color: Colors.grey.shade500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(_post.userName,
                                        style: TextStyle(
                                            color: Colors.grey.shade500)),
                                  ),
                                  Text(
                                    _post.postText,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 16),
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Padding(
                                padding: EdgeInsets.only(right: 32),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Icon(Icons.remove_red_eye,
                                          size: 24, color: Colors.grey),
                                    ),
                                    Text((_post.postViewCount ?? 0).toString())
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                                padding: EdgeInsets.only(right: 32),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Icon(Icons.message,
                                          size: 24, color: Colors.grey),
                                    ),
                                    Text((_post.postLastCommentId ?? 0)
                                        .toString())
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(),
                          ),
                          if (userId != null && _post.userId != userId)
                            Observer(builder: (ctx) {
                              final future = postStore.isFavorite;
                              switch (future.status) {
                                case FutureStatus.fulfilled:
                                  final value = future.value;
                                  if (value) {
                                    return Container(
                                      padding: EdgeInsets.only(right: 8),
                                      width: 32,
                                      height: 32,
                                      child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(Icons.favorite,
                                            color: Colors.red),
                                        onPressed: () => _onRemoveFromFavorite(
                                            context, _post),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      padding: EdgeInsets.only(right: 8),
                                      width: 32,
                                      height: 32,
                                      child: IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(Icons.favorite_border),
                                        onPressed: () =>
                                            _onAddToFavorite(context, _post),
                                      ),
                                    );
                                  }
                                  break;
                                default:
                                  break;
                              }

                              return Container(
                                padding: EdgeInsets.only(top: 8, right: 8),
                                width: 32,
                                height: 32,
                                child: CircularProgressIndicator(),
                              );
                            })
                        ],
                      ))
                ],
              )),
        ));
  }
}

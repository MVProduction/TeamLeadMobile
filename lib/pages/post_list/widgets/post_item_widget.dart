import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:team_lead/common/services/contracts/service_post_data.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';
import 'package:team_lead/pages/post_list/stores/post_item_store.dart';
import 'package:team_lead/routes.dart';
import 'package:team_lead/common/date_utils.dart';

/// Элемент поста
class PostItemWidget extends StatelessWidget {
  /// Данные поста
  final PostItemStore postStore;

  ServicePostData get post => postStore.post;

  /// Обрабатывает нажатие на пост
  void _onPostClick(BuildContext context, ServicePostData post) {
    Navigator.pushNamed(context, Routes.DiscussPost, arguments: post.id);
  }

  /// Обрабатывает нажатие удалить из избранного
  void _onRemoveFromFavorite(BuildContext context, ServicePostData post) {
    postStore.removeFavorite();
  }

  /// Обрабатывает нажатие добавить в избранное
  void _onAddToFavorite(BuildContext context, ServicePostData post) {
    postStore.addToFavorite();
  }

  /// Конструктор
  PostItemWidget(this.postStore);

  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    final user = teamLeadAppStore.usersStore.getLoginUser();

    return Padding(
        padding: EdgeInsets.only(bottom: 8, top: 8, right: 16, left: 16),
        child: InkWell(
          onTap: () => _onPostClick(context, post),
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
                                    child: Image(
                                        image: AssetImage(
                                            "assets/dummy_face.jpg"))))),
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
                                          child: Text(post.title,
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
                                        post.createDate.toLocalizedDateString(),
                                        style: TextStyle(
                                            color: Colors.grey.shade500)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(post.userName,
                                        style: TextStyle(
                                            color: Colors.grey.shade500)),
                                  ),
                                  Text(
                                    post.text,
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
                                    Text(post.viewCount.toString())
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
                                    Text(post.viewCount.toString())
                                  ],
                                )),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(),
                          ),
                          if (post.userName != user.name)
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
                                            context, post),
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
                                            _onAddToFavorite(context, post),
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

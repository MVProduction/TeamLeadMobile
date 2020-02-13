// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_post_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritePostListStore on _FavoritePostListStore, Store {
  final _$allPostsAtom = Atom(name: '_FavoritePostListStore.allPosts');

  @override
  ObservableFuture<List<ServicePostData>> get allPosts {
    _$allPostsAtom.context.enforceReadPolicy(_$allPostsAtom);
    _$allPostsAtom.reportObserved();
    return super.allPosts;
  }

  @override
  set allPosts(ObservableFuture<List<ServicePostData>> value) {
    _$allPostsAtom.context.conditionallyRunInAction(() {
      super.allPosts = value;
      _$allPostsAtom.reportChanged();
    }, _$allPostsAtom, name: '${_$allPostsAtom.name}_set');
  }

  final _$fetchPostsAsyncAction = AsyncAction('fetchPosts');

  @override
  Future<dynamic> fetchPosts() {
    return _$fetchPostsAsyncAction.run(() => super.fetchPosts());
  }
}

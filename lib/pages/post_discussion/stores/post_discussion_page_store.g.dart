// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_discussion_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostDiscussionPageStore on _PostDiscussionPageStore, Store {
  final _$postAtom = Atom(name: '_PostDiscussionPageStore.post');

  @override
  ObservableFuture<ServicePostData> get post {
    _$postAtom.context.enforceReadPolicy(_$postAtom);
    _$postAtom.reportObserved();
    return super.post;
  }

  @override
  set post(ObservableFuture<ServicePostData> value) {
    _$postAtom.context.conditionallyRunInAction(() {
      super.post = value;
      _$postAtom.reportChanged();
    }, _$postAtom, name: '${_$postAtom.name}_set');
  }

  final _$_PostDiscussionPageStoreActionController =
      ActionController(name: '_PostDiscussionPageStore');

  @override
  Future<dynamic> fetchPost(int postId) {
    final _$actionInfo =
        _$_PostDiscussionPageStoreActionController.startAction();
    try {
      return super.fetchPost(postId);
    } finally {
      _$_PostDiscussionPageStoreActionController.endAction(_$actionInfo);
    }
  }
}

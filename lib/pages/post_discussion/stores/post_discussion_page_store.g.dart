// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_discussion_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostDiscussionPageStore on _PostDiscussionPageStore, Store {
  Computed<int> _$commentCountComputed;

  @override
  int get commentCount =>
      (_$commentCountComputed ??= Computed<int>(() => super.commentCount))
          .value;

  final _$postAtom = Atom(name: '_PostDiscussionPageStore.post');

  @override
  ObservableFuture<PostWithUserData> get post {
    _$postAtom.context.enforceReadPolicy(_$postAtom);
    _$postAtom.reportObserved();
    return super.post;
  }

  @override
  set post(ObservableFuture<PostWithUserData> value) {
    _$postAtom.context.conditionallyRunInAction(() {
      super.post = value;
      _$postAtom.reportChanged();
    }, _$postAtom, name: '${_$postAtom.name}_set');
  }

  final _$commentsAtom = Atom(name: '_PostDiscussionPageStore.comments');

  @override
  ObservableFuture<List<ServiceCommentData>> get comments {
    _$commentsAtom.context.enforceReadPolicy(_$commentsAtom);
    _$commentsAtom.reportObserved();
    return super.comments;
  }

  @override
  set comments(ObservableFuture<List<ServiceCommentData>> value) {
    _$commentsAtom.context.conditionallyRunInAction(() {
      super.comments = value;
      _$commentsAtom.reportChanged();
    }, _$commentsAtom, name: '${_$commentsAtom.name}_set');
  }

  final _$_PostDiscussionPageStoreActionController =
      ActionController(name: '_PostDiscussionPageStore');

  @override
  Future<dynamic> fetchPost() {
    final _$actionInfo =
        _$_PostDiscussionPageStoreActionController.startAction();
    try {
      return super.fetchPost();
    } finally {
      _$_PostDiscussionPageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> fetchComments() {
    final _$actionInfo =
        _$_PostDiscussionPageStoreActionController.startAction();
    try {
      return super.fetchComments();
    } finally {
      _$_PostDiscussionPageStoreActionController.endAction(_$actionInfo);
    }
  }
}

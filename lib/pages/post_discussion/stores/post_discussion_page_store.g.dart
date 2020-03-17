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
  Computed<bool> _$needShowSendCommentComputed;

  @override
  bool get needShowSendComment => (_$needShowSendCommentComputed ??=
          Computed<bool>(() => super.needShowSendComment))
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
  ObservableFuture<List<CommentWithUserData>> get comments {
    _$commentsAtom.context.enforceReadPolicy(_$commentsAtom);
    _$commentsAtom.reportObserved();
    return super.comments;
  }

  @override
  set comments(ObservableFuture<List<CommentWithUserData>> value) {
    _$commentsAtom.context.conditionallyRunInAction(() {
      super.comments = value;
      _$commentsAtom.reportChanged();
    }, _$commentsAtom, name: '${_$commentsAtom.name}_set');
  }

  final _$needShowEditAtom =
      Atom(name: '_PostDiscussionPageStore.needShowEdit');

  @override
  bool get needShowEdit {
    _$needShowEditAtom.context.enforceReadPolicy(_$needShowEditAtom);
    _$needShowEditAtom.reportObserved();
    return super.needShowEdit;
  }

  @override
  set needShowEdit(bool value) {
    _$needShowEditAtom.context.conditionallyRunInAction(() {
      super.needShowEdit = value;
      _$needShowEditAtom.reportChanged();
    }, _$needShowEditAtom, name: '${_$needShowEditAtom.name}_set');
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

  @override
  Future<dynamic> fetchComments(int postId) {
    final _$actionInfo =
        _$_PostDiscussionPageStoreActionController.startAction();
    try {
      return super.fetchComments(postId);
    } finally {
      _$_PostDiscussionPageStoreActionController.endAction(_$actionInfo);
    }
  }
}

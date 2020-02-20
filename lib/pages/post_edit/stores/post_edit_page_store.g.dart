// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_edit_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostEditPageStore on _PostEditPageStore, Store {
  final _$postAtom = Atom(name: '_PostEditPageStore.post');

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

  final _$stateAtom = Atom(name: '_PostEditPageStore.state');

  @override
  PostEditStateType get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(PostEditStateType value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }

  final _$editPostAsyncAction = AsyncAction('editPost');

  @override
  Future<dynamic> editPost(int postId, String title, String text) {
    return _$editPostAsyncAction.run(() => super.editPost(postId, title, text));
  }

  final _$_PostEditPageStoreActionController =
      ActionController(name: '_PostEditPageStore');

  @override
  Future<dynamic> fetchPost(int postId) {
    final _$actionInfo = _$_PostEditPageStoreActionController.startAction();
    try {
      return super.fetchPost(postId);
    } finally {
      _$_PostEditPageStoreActionController.endAction(_$actionInfo);
    }
  }
}

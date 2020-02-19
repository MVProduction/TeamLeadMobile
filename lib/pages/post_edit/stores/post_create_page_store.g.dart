// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_create_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostCreatePageStore on _PostCreatePageStore, Store {
  final _$stateAtom = Atom(name: '_PostCreatePageStore.state');

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

  final _$createPostAsyncAction = AsyncAction('createPost');

  @override
  Future<dynamic> createPost(String title, String text) {
    return _$createPostAsyncAction.run(() => super.createPost(title, text));
  }
}

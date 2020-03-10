// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_edit_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserEditPageStore on _UserSettingsPageStore, Store {
  final _$stateAtom = Atom(name: '_UserSettingsPageStore.state');

  @override
  UserEditPageStateType get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(UserEditPageStateType value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }

  final _$updateUserAsyncAction = AsyncAction('updateUser');

  @override
  Future<dynamic> updateUser(
      String photoUrl, String name, String contact, String skill) {
    return _$updateUserAsyncAction
        .run(() => super.updateUser(photoUrl, name, contact, skill));
  }
}

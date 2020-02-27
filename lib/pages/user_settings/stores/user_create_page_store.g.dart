// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_create_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserCreatePageStore on _UserCreatePageStore, Store {
  final _$stateAtom = Atom(name: '_UserCreatePageStore.state');

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

  final _$createUserAsyncAction = AsyncAction('createUser');

  @override
  Future<dynamic> createUser(String id, String name, String contacts,
      String skills, BuildContext context) {
    return _$createUserAsyncAction
        .run(() => super.createUser(id, name, contacts, skills, context));
  }
}

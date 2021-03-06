// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginPageStore on _LoginPageStore, Store {
  final _$stateAtom = Atom(name: '_LoginPageStore.state');

  @override
  LoginPageStateType get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(LoginPageStateType value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }

  final _$errorStringAtom = Atom(name: '_LoginPageStore.errorString');

  @override
  String get errorString {
    _$errorStringAtom.context.enforceReadPolicy(_$errorStringAtom);
    _$errorStringAtom.reportObserved();
    return super.errorString;
  }

  @override
  set errorString(String value) {
    _$errorStringAtom.context.conditionallyRunInAction(() {
      super.errorString = value;
      _$errorStringAtom.reportChanged();
    }, _$errorStringAtom, name: '${_$errorStringAtom.name}_set');
  }

  final _$anonymousLoginAsyncAction = AsyncAction('anonymousLogin');

  @override
  Future<dynamic> anonymousLogin(BuildContext context) {
    return _$anonymousLoginAsyncAction.run(() => super.anonymousLogin(context));
  }

  final _$loginGoogleAsyncAction = AsyncAction('loginGoogle');

  @override
  Future<dynamic> loginGoogle(BuildContext context) {
    return _$loginGoogleAsyncAction.run(() => super.loginGoogle(context));
  }
}

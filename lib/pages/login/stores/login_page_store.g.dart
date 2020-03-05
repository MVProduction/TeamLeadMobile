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

  final _$loginGoogleAsyncAction = AsyncAction('loginGoogle');

  @override
  Future<dynamic> loginGoogle(BuildContext context) {
    return _$loginGoogleAsyncAction.run(() => super.loginGoogle(context));
  }

  final _$startLoginGithubAsyncAction = AsyncAction('startLoginGithub');

  @override
  Future<dynamic> startLoginGithub() {
    return _$startLoginGithubAsyncAction.run(() => super.startLoginGithub());
  }
}

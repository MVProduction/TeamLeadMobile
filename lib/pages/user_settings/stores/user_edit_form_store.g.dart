// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_edit_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserEditFormStore on _UserEditFormStore, Store {
  final _$photoFutureAtom = Atom(name: '_UserEditFormStore.photoFuture');

  @override
  ObservableFuture<Widget> get photoFuture {
    _$photoFutureAtom.context.enforceReadPolicy(_$photoFutureAtom);
    _$photoFutureAtom.reportObserved();
    return super.photoFuture;
  }

  @override
  set photoFuture(ObservableFuture<Widget> value) {
    _$photoFutureAtom.context.conditionallyRunInAction(() {
      super.photoFuture = value;
      _$photoFutureAtom.reportChanged();
    }, _$photoFutureAtom, name: '${_$photoFutureAtom.name}_set');
  }

  final _$setPhotoAsyncAction = AsyncAction('setPhoto');

  @override
  Future<dynamic> setPhoto(File file) {
    return _$setPhotoAsyncAction.run(() => super.setPhoto(file));
  }

  final _$_UserEditFormStoreActionController =
      ActionController(name: '_UserEditFormStore');

  @override
  Future<dynamic> fetchPhoto() {
    final _$actionInfo = _$_UserEditFormStoreActionController.startAction();
    try {
      return super.fetchPhoto();
    } finally {
      _$_UserEditFormStoreActionController.endAction(_$actionInfo);
    }
  }
}

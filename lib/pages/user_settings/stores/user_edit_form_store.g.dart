// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_edit_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserEditFormStore on _UserEditFormStore, Store {
  final _$photoImageAtom = Atom(name: '_UserEditFormStore.photoImage');

  @override
  Image get photoImage {
    _$photoImageAtom.context.enforceReadPolicy(_$photoImageAtom);
    _$photoImageAtom.reportObserved();
    return super.photoImage;
  }

  @override
  set photoImage(Image value) {
    _$photoImageAtom.context.conditionallyRunInAction(() {
      super.photoImage = value;
      _$photoImageAtom.reportChanged();
    }, _$photoImageAtom, name: '${_$photoImageAtom.name}_set');
  }
}

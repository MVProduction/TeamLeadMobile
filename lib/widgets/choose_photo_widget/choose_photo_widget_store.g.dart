// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'choose_photo_widget_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChoosePhotoWidgetStore on _ChoosePhotoWidgetStore, Store {
  final _$stateAtom = Atom(name: '_ChoosePhotoWidgetStore.state');

  @override
  ChoosePhotoWidgetStateType get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(ChoosePhotoWidgetStateType value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }
}

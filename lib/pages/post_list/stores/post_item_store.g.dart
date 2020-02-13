// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostItemStore on _PostItemStore, Store {
  final _$isFavoriteAtom = Atom(name: '_PostItemStore.isFavorite');

  @override
  ObservableFuture<bool> get isFavorite {
    _$isFavoriteAtom.context.enforceReadPolicy(_$isFavoriteAtom);
    _$isFavoriteAtom.reportObserved();
    return super.isFavorite;
  }

  @override
  set isFavorite(ObservableFuture<bool> value) {
    _$isFavoriteAtom.context.conditionallyRunInAction(() {
      super.isFavorite = value;
      _$isFavoriteAtom.reportChanged();
    }, _$isFavoriteAtom, name: '${_$isFavoriteAtom.name}_set');
  }

  final _$_PostItemStoreActionController =
      ActionController(name: '_PostItemStore');

  @override
  Future<dynamic> addToFavorite() {
    final _$actionInfo = _$_PostItemStoreActionController.startAction();
    try {
      return super.addToFavorite();
    } finally {
      _$_PostItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> removeFavorite() {
    final _$actionInfo = _$_PostItemStoreActionController.startAction();
    try {
      return super.removeFavorite();
    } finally {
      _$_PostItemStoreActionController.endAction(_$actionInfo);
    }
  }
}

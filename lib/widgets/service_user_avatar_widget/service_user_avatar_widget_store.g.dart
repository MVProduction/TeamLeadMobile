// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_user_avatar_widget_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ServiceUserAvatarStore on _ServiceUserAvatarStore, Store {
  final _$stateAtom = Atom(name: '_ServiceUserAvatarStore.state');

  @override
  ServiceUserAvatarStateType get state {
    _$stateAtom.context.enforceReadPolicy(_$stateAtom);
    _$stateAtom.reportObserved();
    return super.state;
  }

  @override
  set state(ServiceUserAvatarStateType value) {
    _$stateAtom.context.conditionallyRunInAction(() {
      super.state = value;
      _$stateAtom.reportChanged();
    }, _$stateAtom, name: '${_$stateAtom.name}_set');
  }

  final _$imageAtom = Atom(name: '_ServiceUserAvatarStore.image');

  @override
  Widget get image {
    _$imageAtom.context.enforceReadPolicy(_$imageAtom);
    _$imageAtom.reportObserved();
    return super.image;
  }

  @override
  set image(Widget value) {
    _$imageAtom.context.conditionallyRunInAction(() {
      super.image = value;
      _$imageAtom.reportChanged();
    }, _$imageAtom, name: '${_$imageAtom.name}_set');
  }

  final _$fetchImageAsyncAction = AsyncAction('fetchImage');

  @override
  Future<dynamic> fetchImage(String photoUrl) {
    return _$fetchImageAsyncAction.run(() => super.fetchImage(photoUrl));
  }
}

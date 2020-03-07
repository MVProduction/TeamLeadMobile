import 'package:mobx/mobx.dart';
import 'package:team_lead/widgets/choose_photo_widget/choose_photo_widget_state_type.dart';

part 'choose_photo_widget_store.g.dart';

class ChoosePhotoWidgetStore = _ChoosePhotoWidgetStore with _$ChoosePhotoWidgetStore;

/// Состояние компонента выбора фото
abstract class _ChoosePhotoWidgetStore with Store {
  /// Состояние компонента
  @observable
  ChoosePhotoWidgetStateType state = ChoosePhotoWidgetStateType.Init;
}

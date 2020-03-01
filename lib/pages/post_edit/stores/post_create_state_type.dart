/// Состояние создания поста
enum PostCreateStateType {
  /// Режим редактирования
  Edit,

  /// Ожидание сохраниения
  PendingSave,  

  /// Возникла ошибка
  Error
}

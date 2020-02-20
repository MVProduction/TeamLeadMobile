/// Состояние создания поста
enum PostCreateStateType {
  /// Режим редактирования
  Edit,

  /// Ожидание сохраниения
  PendingSave,

  /// Пост создан
  Created,

  /// Возникла ошибка
  Error
}

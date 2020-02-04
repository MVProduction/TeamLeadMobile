import 'package:intl/intl.dart';

/// Утилиты для дат
extension DateUtils on DateTime {
  /// Возвращает форматированную дату и время в зависимости от локализации
  String toLocalizedString() {
    return DateFormat.yMMMd().format(this);
  }
}

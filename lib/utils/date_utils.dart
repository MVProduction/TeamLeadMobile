import 'package:intl/intl.dart';

/// Утилиты для дат
extension DateUtils on DateTime {
  /// Возвращает форматированную дату в зависимости от локализации
  String toLocalizedDateString() {
    return DateFormat.yMMMd().format(this);
  }

  /// Возвращает форматированную дату и время в зависимости от локализации
  String toLocalizedDateTimeString() {
    return DateFormat.MEd().format(this);
  }
}

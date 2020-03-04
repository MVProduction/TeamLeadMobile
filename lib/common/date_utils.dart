import 'package:intl/intl.dart';

/// Утилиты для дат
extension DateUtils on DateTime {
  /// Возвращает локализованный период от даты на которой используется расширение
  /// До даты [endDate]
  /// Если период больше [maxDays] то возвращается локализованная дата
  String toLocalizedDateTimeStringFromDate(DateTime endDate,
      {int maxDays = 0}) {
    final diff = endDate.difference(this);

    final inDays = diff.inDays;

    if (inDays > maxDays) {
      return this.toLocalizedDateTimeString();
    }

    final inHours = diff.inHours;

    /// Если больше чем сутки
    if (inHours > 24) {
      final hour = inHours - inDays * 24;
      // TODO: локализация часа
      return "$inDays день $hour час";
    }

    /// Если период не больше суток но больше или равен часу, то возвращает в часах
    if (inDays < 1 && inHours >= 1) {
      // TODO: локализация часа
      return "$inHours час";
    }

    final inMinutes = diff.inMinutes;

    /// Если меньше часа но больше минуты
    if (inHours < 1 && inMinutes >= 1) {
      // TODO: локализация мин
      return "$inMinutes мин";
    }

    // TODO: локализация сек
    return "${diff.inSeconds} сек";
  }

  /// Возвращает форматированную дату в зависимости от локализации
  String toLocalizedDateString() {
    return DateFormat.yMMMd().format(this);
  }

  /// Возвращает форматированную дату и время в зависимости от локализации
  String toLocalizedDateTimeString() {
    return DateFormat.yMMMd().format(this) +
        " " +
        DateFormat.jms().format(this);
  }
}

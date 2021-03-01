import 'package:intl/intl.dart';

class DateTimeHelper {
  static day2Text(DateTime date, [String format]) {
    if (date == null) {
      return '[NULL';
    }
    format ??= 'dd-MM-yyyy';
    var today = DateTime.now();
    if (date.day == today.day) {
      return 'Hôm nay';
    } else {
      if (date.day == today.add(Duration(days: 1)).day) {
        return 'Ngày mai';
      } else {
        if (date.day == today.add(Duration(days: -1)).day) {
          return 'Hôm qua';
        } else {
          return DateFormat(format).format(date);
        }
      }
    }
  }

  static DateTime text2Date(value) {
    try {
      return DateTime.parse(value.toString().substring(0, 10));
    } catch (_) {
      return DateTime(1, 1, 1);
    }
  }
}

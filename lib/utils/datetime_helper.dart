import 'package:intl/intl.dart';

class DateTimeHelper {
  static day2Text(DateTime date) {
    if (date == null) {
      return '[NULL';
    }
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
          return DateFormat('dd-MM-yyyy').format(date);
        }
      }
    }
  }
}

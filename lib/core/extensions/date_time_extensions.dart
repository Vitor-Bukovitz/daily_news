import 'package:intl/intl.dart';

extension CustomizableDateTime on DateTime {
  static DateTime? _customTime;
  static DateTime get current {
    return _customTime ?? DateTime.now();
  }

  static set current(DateTime current) {
    _customTime = current;
  }
}

extension FormatDateTime on DateTime {
  String toDateString() {
    return DateFormat.yMMMMd().format(this);
  }
}

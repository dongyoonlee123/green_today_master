import 'package:green_today/consts.dart';
import 'package:intl/intl.dart';

extension DateTimeInequality on DateTime {
  bool operator <(DateTime rhs) {
    return this.isBefore(rhs);
  }

  bool operator >(DateTime rhs) {
    return this.isAfter(rhs);
  }

  bool operator >=(DateTime rhs) {
    return this > rhs || this == rhs;
  }

  bool operator <=(DateTime rhs) {
    return this < rhs || this == rhs;
  }
}

extension DateTimeJson on DateTime {
  Map<dynamic, dynamic> get json {
    return {'hour': hour, 'minute': minute};
  }
}

DateTime dateFromJson(String dateString, Map<dynamic, dynamic> dateMap) {
  final formatter = DateConst.formatter;
  final date = formatter.parse(dateString);
  return DateTime(
      date.year, date.month, date.day, dateMap['hour'], dateMap['minute']);
}

class SimpleTime {
  int hour;
  int minute;

  SimpleTime(this.hour, this.minute);

  SimpleTime.fromJson(Map<dynamic, dynamic> simpleTimeJson) :
      this(simpleTimeJson['hour'], simpleTimeJson['minute']);

  Map<dynamic, dynamic> get json {
    return {
      'hour': hour,
      'minute': minute
    };
  }
}

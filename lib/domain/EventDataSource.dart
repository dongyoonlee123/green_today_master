import 'dart:ui';

import 'package:green_today/palette.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource<Event> extends CalendarDataSource<Event> {
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }

  int getAchievementRate(int index) {
    return appointments![index].achievementRate;
  }

  int getAvgAchievementRate() {
    return appointments!.fold(
            0,
            (previousValue, element) =>
                (previousValue + element.achievementRate) as int) ~/
        appointments!.length;
  }
}

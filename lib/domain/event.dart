import 'dart:ui';

import 'package:green_today/domain/time.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../palette.dart';

class Event extends Appointment {
  Event(
      {required super.startTime,
      required super.endTime,
      super.subject,
      int achievementRate = 0})
      : _achievementRate = achievementRate,
        super() {
    this.achievementRate = _achievementRate;
  }

  Event.fromAppointment(Appointment appointment)
      : _achievementRate = getAchievementRateFrom(appointment.color),
        super(
            startTime: appointment.startTime,
            endTime: appointment.endTime,
            subject: appointment.subject) {
    this.achievementRate = _achievementRate;
  }

  int _achievementRate;

  int get achievementRate => _achievementRate;

  set achievementRate(int value) {
    _achievementRate = value;
    int roundedRate = (_achievementRate.toDouble() / 10).round();
    super.color = GreenPicker.getGreenFor(roundedRate);
  }

  static int getAchievementRateFrom(Color green) {
    int result = 0;

    if (green == GreenPicker.p0.color) {
      result = 0;
    } else if (green == GreenPicker.p10.color) {
      result = 10;
    } else if (green == GreenPicker.p20.color) {
      result = 20;
    } else if (green == GreenPicker.p30.color) {
      result = 30;
    } else if (green == GreenPicker.p40.color) {
      result = 40;
    } else if (green == GreenPicker.p50.color) {
      result = 50;
    } else if (green == GreenPicker.p60.color) {
      result = 60;
    } else if (green == GreenPicker.p70.color) {
      result = 70;
    } else if (green == GreenPicker.p80.color) {
      result = 80;
    } else if (green == GreenPicker.p90.color) {
      result = 90;
    } else if (green == GreenPicker.p100.color) {
      result = 100;
    } else {
      throw UnimplementedError("Wrong usage of green for achievement rate");
    }

    return result;
  }

  Map<dynamic, dynamic> get json {
    return {
      'start_time': startTime.json,
      'end_time': endTime.json,
      'subject': subject,
      'achievement_rate': achievementRate
    };
  }

  Event.fromJson(String dateString, Map<dynamic, dynamic> eventMap) : this(
    startTime: dateFromJson(dateString, eventMap['start_time']),
    endTime:  dateFromJson(dateString, eventMap['end_time']),
    subject: eventMap['subject'],
    achievementRate: eventMap['achievement_rate']
  );
}

//

//    return Event(startTime: startTime, endTime: endTime,
//

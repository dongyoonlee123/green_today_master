import 'package:green_today/domain/time.dart';

class Settings {
  SimpleTime morningNotiTime;
  SimpleTime eveningNotiTime;

  Settings(this.morningNotiTime, this.eveningNotiTime);

  Settings.fromJson(Map<dynamic, dynamic> settingsJson) :
      this(SimpleTime.fromJson(settingsJson['morning_noti_time']),
        SimpleTime.fromJson(settingsJson['evening_noti_time'])
      );

  Map<dynamic, dynamic> get json {
    return {
      'morning_noti_time': morningNotiTime.json,
      'evening_noti_time': eveningNotiTime.json
    };
  }
}

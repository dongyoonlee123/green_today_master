import 'package:flutter/material.dart';
import 'package:green_today/business/calendar_event_control.dart';
import 'package:green_today/domain/event.dart';
import 'package:green_today/palette.dart';
import 'package:green_today/repo/EventRepository.dart';
import 'package:green_today/screens/add_event_dialog.dart';
import 'package:green_today/screens/setting.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:time/time.dart';

import 'package:collection/collection.dart';

import 'edit_event_dialog.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({super.key});

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const TodayHeader(),
            Expanded(child: Consumer<EventController>(
              builder: (BuildContext context, eventController, Widget? child) {
                return SfCalendar(
                  allowAppointmentResize: true,
                  allowDragAndDrop: false,
                  dataSource: eventController.dataSource,
                  appointmentTextStyle: TextStyle(
                      fontSize: 20,
                      color: Color(0xffaaaaaa),
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold),
                  onAppointmentResizeStart: (details) {
                    final Event event = details.appointment;
                    eventController.removeEvent(event);
                  },
                  onAppointmentResizeEnd: (details) {
                    final Appointment appointment = details.appointment;
                    final Event event = Event.fromAppointment(appointment);
                    eventController.removeAppointment(appointment);
                    eventController.addEvent(event);
                  },
                  onTap: (calendarTapDetails) {
                    final Event tappedEvent =
                        calendarTapDetails.appointments!.firstOrNull;
                    showDialog(
                      context: context,
                      builder: (context) => EventEditDialog(
                        startTime: tappedEvent.startTime,
                        endTime: tappedEvent.endTime,
                        tapDetails: calendarTapDetails,
                      ),
                    );
                  },
                  onLongPress: (calendarLongPressDetails) {
                    final startTime = calendarLongPressDetails.date!;
                    final endTime = startTime + 1.hours;

                    showDialog(
                        context: context,
                        builder: (context) => EventAddDialog(
                              startTime: startTime,
                              endTime: endTime,
                            ));
                  },
                );
              },
            ))
          ],
        ),
        floatingActionButton: EventAddButton());
  }
}

class EventAddButton extends StatelessWidget {
  const EventAddButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return EventAddDialog();
            });
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: GreenPicker.p80.color,
      ),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}

class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 36,
          child: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const SettingDialog());
              },
              icon: const Icon(Icons.settings)),
        ),
        ..._percentPalette()
      ],
    );
  }

  List<Widget> _percentPalette() {
    return List<ColorTile>.generate(11, (index) {
      if (index == 0) {
        return ColorTile(
          GreenPicker.getGreenFor(index),
          text: const Text(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
              "0"),
        );
      } else if (index == 10) {
        return ColorTile(
          GreenPicker.getGreenFor(index),
          text: const Text(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
              "100"),
        );
      } else {
        return ColorTile(GreenPicker.getGreenFor(index));
      }
    });
  }
}

class ColorTile extends StatelessWidget {
  final Color _color;
  final Text? text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
            color: _color,
            child: SizedBox(
              height: 26,
              child: text,
            )));
  }

  const ColorTile(this._color, {super.key, this.text});
}

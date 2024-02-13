import 'package:flutter/material.dart';
import 'package:green_today/business/calendar_event_control.dart';
import 'package:green_today/domain/event.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../domain/time.dart';

class EventEditDialog extends StatefulWidget {
  DateTime? startTime;
  DateTime? endTime;
  final CalendarTapDetails tapDetails;

  EventEditDialog({super.key, this.startTime, this
      .endTime, required this.tapDetails});

  @override
  State<EventEditDialog> createState() => _EventEditDialogState();
}

class _EventEditDialogState extends State<EventEditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SimpleTime startTime = SimpleTime(0, 0);
  late SimpleTime endTime = SimpleTime(0, 0);
  late Event targetEvent;
  String? todo;
  int achievementRate = 0;


  @override
  void initState() {
    super.initState();
    if (widget.startTime != null) {
      startTime = SimpleTime(widget.startTime!.hour, widget.startTime!.minute);
    } else {
      endTime = SimpleTime(0, 0);
    }

    if (widget.endTime != null) {
      endTime = SimpleTime(widget.endTime!.hour, widget.endTime!.minute);
    } else {
      endTime = SimpleTime(0, 0);
    }

    targetEvent = widget.tapDetails.appointments![0];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(10), child: ElevatedButton(
                onPressed: () {
                  Provider.of<EventController>(context, listen: false).removeEvent(targetEvent);
                  Navigator.pop(context);
                }, child: Text("Remove event"),
            )
              ,),
            SizedBox(height: 10,),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Text(
                    "  Start Time Set     ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: startTime.hour,
                      items: List.generate(24, (i) {
                        if (i < 10) {
                          return DropdownMenuItem(value: i, child: Text('0$i'));
                        }
                        return DropdownMenuItem(value: i, child: Text('$i'));
                      }),
                      onChanged: (int? value) {
                        setState(() {
                          startTime.hour = value!;
                        });
                      },
                    ),
                  ),
                  const Text(
                    " : ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: startTime.minute,
                      items: List.generate(60, (i) {
                        if (i < 10) {
                          return DropdownMenuItem(value: i, child: Text('0$i'));
                        }
                        return DropdownMenuItem(value: i, child: Text('$i'));
                      }),
                      onChanged: (int? value) {
                        setState(() {
                          startTime.minute = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                children: [
                  const Text(
                    "   End Time Set      ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: endTime.hour,
                      items: List.generate(24, (i) {
                        if (i < 10) {
                          return DropdownMenuItem(value: i, child: Text('0$i'));
                        }
                        return DropdownMenuItem(value: i, child: Text('$i'));
                      }),
                      onChanged: (int? value) {
                        setState(() {
                          endTime.hour = value!;
                        });
                      },
                    ),
                  ),
                  const Text(
                    " : ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: endTime.minute,
                      items: List.generate(60, (i) {
                        if (i < 10) {
                          return DropdownMenuItem(value: i, child: Text('0$i'));
                        }
                        return DropdownMenuItem(value: i, child: Text('$i'));
                      }),
                      onChanged: (int? value) {
                        setState(() {
                          endTime.minute = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'To do',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    todo = value ?? '';
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      "Achievement Rate",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: achievementRate,
                      items: List.generate(11, (i) {
                        return DropdownMenuItem(
                            value: i * 10, child: Text('${i * 10}'));
                      }),
                      onChanged: (int? value) {
                        setState(() {
                          achievementRate = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: TextButton(
                onPressed: () {
                  final now = DateTime.now();
                  final newStartTime = DateTime(now.year, now.month, now.day,
                      startTime.hour!, startTime.minute!);
                  final newEndTime = DateTime(now.year, now.month, now.day,
                      endTime.hour!, endTime.minute!);
                  final newEvent = Event(
                      startTime: newStartTime,
                      endTime: newEndTime,
                      subject: todo ?? '',
                      achievementRate: achievementRate
                  );
                  final eventController = Provider.of<EventController>
                    (context, listen: false);
                  eventController.updateEvent(targetEvent, newEvent);
                  Navigator.pop(context);
                },
                // 버튼에 텍스트 부여
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

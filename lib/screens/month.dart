import 'package:flutter/material.dart';
import 'package:green_today/business/calendar_event_control.dart';
import 'package:green_today/repo/DayReviewRepository.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthScreen extends StatefulWidget {
  @override
  State<MonthScreen> createState() => _MonthScreenState();
}

class _MonthScreenState extends State<MonthScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          flex: 3,
          child: Consumer<EventController>(
            builder: (BuildContext context, eventController, Widget? child) {
              return SfCalendar(
                dataSource: eventController.dataSource,
                view: CalendarView.month,
                appointmentTextStyle: TextStyle(
                    fontSize: 20,
                    color: Color(0xffaaaaaa),
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold),
                onTap: (calendarTapDetails) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Provider.value(
                                value: eventController,
                                builder: (context, child) {
                                  return SfCalendar(
                                    dataSource: Provider.of<EventController>(
                                            context,
                                            listen: false)
                                        .dataSource,
                                    appointmentTextStyle: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xffaaaaaa),
                                        letterSpacing: 5,
                                        fontWeight: FontWeight.bold),
                                    view: CalendarView.day,
                                    headerHeight: 0,
                                  );
                                },
                              )));
                },
              );
            },
          )),
      Expanded(flex: 2, child: DayReview())
    ]);
  }
}

class DayReview extends StatefulWidget {
  @override
  State<DayReview> createState() => _DayReviewState();
}

class _DayReviewState extends State<DayReview> {
  final _todayReviewEditingController = TextEditingController();
  late final DayReviewRepository _reviewRepository;

  @override
  void initState() {
    super.initState();
    _reviewRepository =
        Provider.of<DayReviewRepository>(context, listen: false);
    _reviewRepository
        .get(DateTime.now())
        .then((value) => _todayReviewEditingController.text = value ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(flex: 7, child: Container()),
            Expanded(
              flex: 86,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Colors.grey,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _todayReviewEditingController,
                          maxLines: 4,
                          decoration: InputDecoration(hintText: '오늘 하루는 어땠나요?'),
                          onSubmitted: (String? value) {
                            final text = value ?? '';
                            _todayReviewEditingController.text = text;
                            _reviewRepository.update(DateTime.now(), text);
                          },
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("")
                ],
              ),
            ),
            Expanded(flex: 7, child: Container())
          ],
        )
      ],
    );
  }
}

import 'package:green_today/domain/EventDataSource.dart';
import 'package:green_today/domain/event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:collection/collection.dart';

import '../repo/EventRepository.dart';

class EventController {
  final EventDataSource _dataSource;
  late final List<dynamic> _appointments;

  late final EventRepository _eventRepository = EventRepository();

  EventController(this._dataSource) {
    _dataSource.appointments ??= [];
    _appointments = _dataSource.appointments!;
  }

  EventDataSource get dataSource => _dataSource;

  Future<void> addEvent(Event event) async {
    addAppointment(event);
    await _eventRepository.create(event);
  }

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    _dataSource.notifyListeners(
        CalendarDataSourceAction.add, _dataSource.appointments!);
  }

  Future<void> updateEvent(Event targetEvent, Event updatingEvent) async {
    removeAppointment(targetEvent);
    addAppointment(updatingEvent);
    await _eventRepository.update(targetEvent, updatingEvent);
  }

  void updateAppointment(
      Appointment targetAppointment, Appointment updatingAppointment) {
    removeAppointment(targetAppointment);
    addAppointment(updatingAppointment);
  }

  Future<void> removeEvent(Event event) async {
    removeAppointment(event);
    await _eventRepository.delete(event);
  }

  void removeAppointment(Appointment appointment) {
    _appointments.removeAt(_appointments.indexOf(appointment));
    _dataSource.notifyListeners(
        CalendarDataSourceAction.remove, <Appointment>[]..add(appointment));
  }

  Future<void> loadMonthEvents(DateTime monthDate) async {
    List<Event> events = await _eventRepository.getInMonth(monthDate);
    _appointments.addAll(events);
    _dataSource.notifyListeners(
        CalendarDataSourceAction.add, _dataSource.appointments!);
  }
}

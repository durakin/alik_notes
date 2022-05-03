import 'package:alik_notes/model/event.dart';

import 'boxes.dart';

Future<void> editEvent(Event event, String newName, String? newPlace, DateTime newDateTime) {
  event.name = newName;
  event.place = newPlace;
  event.dateTime = newDateTime;
  return event.save();
}

Future<void> addEvent(Event event) {
  return Boxes.getEvents().add(event);
}

Future<void> deleteEvent(Event event) {
  return event.delete();
}
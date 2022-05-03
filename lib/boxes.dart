import 'package:hive/hive.dart';
import 'package:alik_notes/model/note.dart';
import 'package:alik_notes/model/event.dart';

class Boxes {
  static Box<Note> getNotes() =>
      Hive.box<Note>('notes');
  static Box<Event> getEvents() =>
      Hive.box<Event>('events');
}

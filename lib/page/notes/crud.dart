import 'package:alik_notes/model/note.dart';

import '../../boxes.dart';

void editNote(Note note) {

}

Future<void> addNote(Note note) {
  return Boxes.getNotes().add(note);
}

Future<void> deleteNote(Note note) {
  return note.delete();
}
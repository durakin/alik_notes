import 'package:alik_notes/model/note.dart';

import '../../boxes.dart';

Future<void> editNote(Note note, String newName, String newText) {
  note.name = newName;
  note.text = newText;
  return note.save();
}

Future<void> addNote(Note note) {
  return Boxes.getNotes().add(note);
}

Future<void> deleteNote(Note note) {
  return note.delete();
}
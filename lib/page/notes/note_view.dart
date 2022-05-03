import 'package:alik_notes/model/note.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'crud.dart';
import 'note_edit.dart';


class NoteView extends StatefulWidget {
  final Note note;
  @override
  _NoteViewState createState() => _NoteViewState();
  const NoteView({Key? key, required this.note}) : super(key: key);
}

class _NoteViewState extends State<NoteView> {

  Widget build(BuildContext context) {
    final note = widget.note;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            note.name,
            maxLines: 1,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteEdit(note: note)));
              },
              tooltip: "Редактировать",
            ),
            IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.white,
              ),
              onPressed: () {
                deleteNote(note);
                Navigator.pop(context);
              },
              tooltip: "Удалить",
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            note.text,
            style: (Theme.of(context).textTheme.subtitle1)
                ?.copyWith(color: Colors.white),
          ),
        ));
  }
}

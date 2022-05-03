import 'package:alik_notes/model/note.dart';
import 'package:alik_notes/page/notes/crud.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteEdit extends StatelessWidget {
  final Note? note;

  const NoteEdit({Key? key, required this.note}) : super(key: key);

  Widget build(BuildContext context) {
    var nameController = TextEditingController(text: (note != null) ? note?.name : "");
    var textController = TextEditingController(text: (note != null) ? note?.text : "");

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: Theme.of(context).textTheme.headline6,
          decoration: const InputDecoration(
            hintText: "Название",
          ),
          maxLines: 1,
          controller:
          nameController,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              if (note == null) {
                addNote(Note(
                  nameController.text,
                  textController.text,
                  null,
                ));
              }
              else print("Trying to edit note");
              Navigator.pop(context);
            },
            tooltip: "Сохранить",
          ),
        ],
      ),
      body: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            hintText: "Содержание", contentPadding: EdgeInsets.all(16)),
        controller:
        textController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}

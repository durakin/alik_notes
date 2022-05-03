import 'package:alik_notes/model/note.dart';
import 'package:alik_notes/events.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../boxes.dart';
import '../../model/note.dart';
import 'note_edit.dart';
import 'note_view.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  @override
  void dispose() {
    Hive.box('notes').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Container(
              margin: const EdgeInsets.only(top: 60),
              child: ListView(children: [
                ListTile(
                  leading: const Icon(Icons.calendar_today_outlined,
                      color: Colors.white),
                  title: Text(
                    "События",
                    style: (Theme.of(context).textTheme.headline6)
                        ?.copyWith(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Events()));
                  },
                ),
                //const Divider(height: 16, thickness: 0,),
                ListTile(
                  leading: const Icon(Icons.sticky_note_2_outlined,
                      color: Colors.white),
                  title: Text("Заметки",
                      style: (Theme.of(context).textTheme.headline6)
                          ?.copyWith(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Notes()));
                  },
                ),
                const Divider(thickness: 2),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.white),
                  title: Text("О приложении",
                      style: (Theme.of(context).textTheme.headline6)
                          ?.copyWith(color: Colors.white)),
                  onTap: () {},
                )
              ]))),
      appBar: AppBar(
        title: const Text('Заметки'),
      ),
      body: ValueListenableBuilder<Box<Note>>(
        valueListenable: Boxes.getNotes().listenable(),
        builder: (context, box, _) {
          final notes = box.values.toList().cast<Note>();
          return buildContent(notes, context);
        },
      ),      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NoteEdit(note: null)));
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.sticky_note_2_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildContent(List<Note> notes, BuildContext context) {
    final tiles = notes.map((note) => ListTile(
        title: Text(
          note.name,
          maxLines: 1,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(note.plainText, maxLines: 1),
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteView(note: note)));
        }));

    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList()
        : <Widget>[];

    return ListView(children: divided);
  }
}

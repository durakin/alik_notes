import 'package:alik_notes/events.dart';
import 'package:flutter/material.dart';

class Note {
  final String name;
  final String text;

  String get plainText => text.replaceAll('\n', ' ');

  const Note(this.name, this.text);
}

class NoteEdit extends StatelessWidget {
  final Note? note;

  const NoteEdit({Key? key, required this.note}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: Theme.of(context).textTheme.headline6,
          decoration: const InputDecoration(
            hintText: "Название",
          ),
          maxLines: 1,
          controller:
              TextEditingController(text: (note != null) ? note?.name : ""),
        ),
        actions: const [
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: null,
            tooltip: "Сохранить",
          ),
        ],
      ),
      body: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            hintText: "Содержание", contentPadding: EdgeInsets.all(16)),
        controller: TextEditingController(
          text: (note != null) ? note?.text : "",
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
    );
  }
}

class NoteView extends StatelessWidget {
  const NoteView({Key? key, required this.note}) : super(key: key);

  final Note note;

  Widget build(BuildContext context) {
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
              onPressed: null,
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

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  //final _saved = <WordPair>{};
  final _notes = <Note>[
    const Note("Список покупок",
        "Копченая колбаса\nСыр волна\nЛимонад \"Колокольчик\" FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF"),
    const Note(
        "Wireguard config", "[Interface] Privatekey = <Сюда приватый ключ>"),
  ];

  @override
  Widget build(BuildContext context) {
    final tiles = _notes.map((note) => ListTile(
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
                        MaterialPageRoute(builder: (context) => const Notes()));
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
      body: ListView(children: divided),
      floatingActionButton: FloatingActionButton(
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
}

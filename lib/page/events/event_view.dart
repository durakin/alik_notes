import 'package:alik_notes/db/events_crud.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alik_notes/model/event.dart';

import 'event_edit.dart';

class EventView extends StatelessWidget {
  const EventView({Key? key, required this.event}) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          event.name,
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
                      builder: (context) => EventEdit(event: event)));
            },
            //onPressed: () {
            //  Navigator.push(
            //      context,
            //      MaterialPageRoute(
            //          builder: (context) => NoteEdit(note: note)));
            //},
            tooltip: "Редактировать",
          ),
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
            onPressed: () {
              deleteEvent(event);
              Navigator.pop(context);
            },
            tooltip: "Удалить",
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            shape: const Border(
              top: BorderSide(width: 0),
            ),
            color: const Color(0xff263238),
            child: ListTile(
                title:
                    const Text("Время", style: TextStyle(color: Colors.white)),
                trailing: Text(
                  DateFormat.yMd().add_Hm().format(event.dateTime.toUtc()),
                  style: const TextStyle(color: Colors.white),
                )),
            //color: Colors.blue,
            margin: const EdgeInsets.all(0),
          ),
          const Divider(
            thickness: 16,
            color: Color(0xff263238),
          ),
          Card(
            child: ListTile(
              title: Text(
                event.weather,
                style: const TextStyle(color: Colors.white),
              ),
              leading:
                  const Icon(Icons.thermostat_outlined, color: Colors.white),
            ),
            color: const Color(0xff263238),
          ),
          Card(
            child: ListTile(
              title: Text(
                event.plainText,
                style: const TextStyle(color: Colors.white),
              ),
              leading: const Icon(Icons.place_outlined, color: Colors.white),
            ),
            color: const Color(0xff263238),
          ),
          const Padding(
              padding: EdgeInsets.all(16),
              child: Image(image: AssetImage('assets/map.png'))),
        ],
      ),
    );
  }
}

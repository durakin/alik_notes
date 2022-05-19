import 'package:alik_notes/page/notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:alik_notes/model/event.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../db/boxes.dart';
import '../map/map.dart';
import 'event_edit.dart';
import 'event_view.dart';
import '../weather/weather.dart';

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
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
                  leading: const Icon(Icons.map_outlined, color: Colors.white),
                  title: Text("Карта",
                      style: (Theme.of(context).textTheme.headline6)
                          ?.copyWith(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MapPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.map_outlined, color: Colors.white),
                  title: Text("Погода",
                      style: (Theme.of(context).textTheme.headline6)
                          ?.copyWith(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WeatherPage()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline, color: Colors.white),
                  title: Text("О приложении",
                      style: (Theme.of(context).textTheme.headline6)
                          ?.copyWith(color: Colors.white)),
                  onTap: () {},
                )
              ]))),
      appBar: AppBar(
        title: const Text('События'),
      ),
      body: ValueListenableBuilder<Box<Event>>(
          valueListenable: Boxes.getEvents().listenable(),
          builder: (context, box, _) {
            final events = box.values.toList().cast<Event>();
            return buidContent(events, context);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EventEdit(event: null)));
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.edit_calendar_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buidContent(List<Event> events, BuildContext context) {
    final futureEvents = events.where(
        (element) => element.dateTime.toUtc().isAfter(DateTime.now().toUtc()));
    final pastEvents =
        events.where((element) => !futureEvents.contains(element));

    final futuretiles = futureEvents.map((event) => ListTile(
          title: Text(
            event.name,
            maxLines: 1,
            style: const TextStyle(color: Colors.white),
            //style: _biggerFont,
          ),
          subtitle: Text(event.plainText, maxLines: 1),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventView(event: event)));
          },
        ));
    final pastTiles = pastEvents.map((event) => ListTile(
          title: Text(
            event.name,
            maxLines: 1,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(event.plainText, maxLines: 1),
          trailing: Column(
            children: [
              Text(event.dateText),
            ],
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EventView(event: event)));
          },
        ));

    final dividedFuture = futureEvents.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: futuretiles,
          ).toList()
        : <ListTile>[];

    final dividedPast = pastEvents.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: pastTiles,
          ).toList()
        : <ListTile>[];

    return ListView(children: dividedFuture + dividedPast);
  }
}

import 'package:alik_notes/notes.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  final String name;
  final DateTime dateTime;
  final String? place;

  bool get isPast => DateTime.now().toUtc().isAfter(dateTime);
  bool get isSoon =>
      DateTime.now().add(const Duration(hours: 24)).toUtc().isAfter(dateTime);

  String get weather => "+7, Гроза";
  String get plainText =>
      (place != null) ? place!.replaceAll("\n", " ") : "Место не указано";
  String get dateText => (isPast
      ? DateFormat.Md().add_y().format(dateTime.toUtc())
      : isSoon
          ? DateFormat.Hm().format(dateTime.toUtc())
          : DateFormat.Md().add_Hm().format(dateTime.toUtc()));

  const Event(this.name, this.dateTime, this.place);
}

class EventEdit extends StatelessWidget {
  final Event? event;

  const EventEdit({Key? key, required this.event}) : super(key: key);

  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: TextField(
            style: Theme.of(context).textTheme.headline6,
            decoration: const InputDecoration(
              hintText: "Событие",
            ),
            maxLines: 1,
            controller:
                TextEditingController(text: (event != null) ? event?.name : ""),
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
        body: Column(
          children: [
            Card(
              shape: const Border(
                top: BorderSide(width: 0),
              ),
              color: const Color(0xff263238),

              child: ListTile(
                  leading: const Text(
                    "Время",
                    style: TextStyle(color: Colors.white),
                  ),
                  title: DateTimeField(
                    style: const TextStyle(color: Colors.white),
                    format: format,
                    initialValue:
                        event != null ? event!.dateTime : DateTime.now(),
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate:
                              event != null ? event!.dateTime : DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(event != null
                                ? event!.dateTime
                                : DateTime.now()));
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
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
                leading: const Icon(Icons.place_outlined, color: Colors.white),
                title: TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: "Место", contentPadding: EdgeInsets.all(16)),
                  controller: TextEditingController(
                      text: (event != null) ? event?.place : ""),
                ),
              ),
              color: const Color(0xff263238),
            ),
            const Padding(
                padding: EdgeInsets.all(16),
                child: Image(image: AssetImage('assets/map.png'))),
          ],
        ));
  }
}

class EventView extends StatelessWidget {
  const EventView({Key? key, required this.event}) : super(key: key);

  final Event event;

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
          const IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
            onPressed: null,
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

class Events extends StatefulWidget {
  const Events({Key? key}) : super(key: key);

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  final _events = <Event>[
    Event("Концерт", DateTime(2022, 4, 23, 19, 0, 0, 0, 0).toUtc(),
        "МВДЦ \"Сибирь\" ул. Авиаторов, 19"),
    Event("Парикмахер", DateTime(2022, 4, 22, 19, 0, 0, 0, 0).toUtc(),
        "\"Голый пистолет\", салон красоты ул. Пушкина, дом Колотушкина"),
    Event("Врач", DateTime(2021, 1, 1, 19, 0, 0, 0, 0).toUtc(), null),
  ];

  @override
  Widget build(BuildContext context) {
    final futureEvents = _events.where(
        (element) => element.dateTime.toUtc().isAfter(DateTime.now().toUtc()));
    final pastEvents =
        _events.where((element) => !futureEvents.contains(element));

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
          trailing: Column(
            children: [
              Text(event.dateText),
              Icon(Icons.bolt_outlined),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
          /*() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NoteView(note: note)));
            }
             */
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
        : <Widget>[];

    final dividedPast = pastEvents.isNotEmpty
        ? ListTile.divideTiles(
            context: context,
            tiles: pastTiles,
          ).toList()
        : <Widget>[];

    dividedFuture.add(const Divider(thickness: 8));
    dividedFuture.addAll(dividedPast);

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
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Notes()));
                    },
                  ),
                  const Divider(thickness: 2),
                  ListTile(
                    leading:
                        const Icon(Icons.info_outline, color: Colors.white),
                    title: Text("О приложении",
                        style: (Theme.of(context).textTheme.headline6)
                            ?.copyWith(color: Colors.white)),
                    onTap: () {},
                  )
                ]))),
        appBar: AppBar(
          title: const Text('События'),
        ),
        body: ListView(children: dividedFuture),
        //floatingActionButton: FloatingActionButton(
        //  onPressed: () {
        //    Navigator.push(context,
        //        MaterialPageRoute(builder: (context) => const NoteEdit(note: null)));
        //  },
        //  backgroundColor: Colors.red,
        //  child: const Icon(Icons.sticky_note_2_outlined, color: Colors.white,),
        //),
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
        ));
  }
}

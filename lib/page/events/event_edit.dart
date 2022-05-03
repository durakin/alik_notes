import 'dart:math';

import 'package:alik_notes/page/events/event_view.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alik_notes/model/event.dart';

import '../../db/events_crud.dart';


class EventEdit extends StatelessWidget {
  final Event? event;

  const EventEdit({Key? key, required this.event}) : super(key: key);

  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    var nameController = TextEditingController(text: (event != null) ? event?.name : "");
    var placeController = TextEditingController(text: (event != null) ? event?.place : "");
    var pickedTime = event != null ? event!.dateTime : DateTime.now();
    var picker = DateTimeField(
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
          pickedTime = DateTimeField.combine(date, time);
          return DateTimeField.combine(date, time);
        } else {
          pickedTime = currentValue!;
          return currentValue;
        }
      },

    );

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: TextField(
            style: Theme.of(context).textTheme.headline6,
            decoration: const InputDecoration(
              hintText: "Событие",
            ),
            maxLines: 1,
            controller: nameController,
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.done,
                color: Colors.white,
              ),
              onPressed: () {
                if (event == null) {
                  addEvent(Event(
                      nameController.text,
                      pickedTime,
                      placeController.text,));
                  Navigator.pop(context);
                  }
                else {
                  editEvent(event!, nameController.text, placeController.text, pickedTime);
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EventView(event: event!)));
                }
              },
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
                  title: picker),
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
                  controller: placeController,
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

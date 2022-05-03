// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:alik_notes/model/event.dart';
import 'package:alik_notes/page/notes/notes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'boxes.dart';
import 'model/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(EventAdapter());
  await Hive.openBox<Note>('notes');
  await Hive.openBox<Event>('events');
  Boxes.getNotes().add(Note("Kavo", "Suchara"));
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Alik notes",
      home: Notes(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
        ).copyWith(primary: const Color(0xff263238)),
        canvasColor: Colors.blueGrey,

        textTheme: const TextTheme(
          headline6: TextStyle(color: Colors.red),
        ).apply(bodyColor: Colors.white,
          displayColor: Colors.white,),

        textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.red, selectionHandleColor: Colors.red),
      ),
    );
  }
}

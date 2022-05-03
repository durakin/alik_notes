import 'dart:ffi';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'event.g.dart';

@HiveType(typeId: 1)
class Event extends HiveObject {
  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime dateTime;

  @HiveField(3)
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

  Event(this.name, this.dateTime, this.place);

  Event copy({
    int? id,
    String? name,
    DateTime? dateTime,
    String? place,
    bool? isPlaceGeo,
    String? text,
  }) =>
      Event(
        name ?? this.name,
        dateTime ?? this.dateTime,
        place ?? this.place,
      );
}

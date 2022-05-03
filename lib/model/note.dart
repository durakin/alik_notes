import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String text;

  String get plainText => text.replaceAll('\n', ' ');

  Note(this.name, this.text);

  Note copy({
    int? id,
    String? name,
    String? text,
  }) =>
      Note(
        name ?? this.name,
        text ?? this.text,
      );
}

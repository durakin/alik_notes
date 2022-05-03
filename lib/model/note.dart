import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String text;

  String get plainText => text.replaceAll('\n', ' ');

  Note(this.name, this.text, this.id);

  Note copy({
    int? id,
    String? name,
    String? text,
  }) =>
      Note(
        name ?? this.name,
        text ?? this.text,
        id ?? this.id,
      );
}

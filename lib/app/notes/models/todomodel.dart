import 'package:isar/isar.dart';
part 'todomodel.g.dart';

@embedded
class ToDoModel {
  late final int id;
  late final String title;
  late final String? description;
  late final bool check;

  ToDoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? check,
  }) {
    return ToDoModel()
      ..id = id ?? DateTime.now().millisecondsSinceEpoch
      ..title = title ?? ''
      ..description = description ?? ''
      ..check = check ?? false;
  }
}

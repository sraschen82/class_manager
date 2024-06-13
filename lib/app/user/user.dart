import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/notes/models/todomodel.dart';
import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection(inheritance: false, accessor: 'user')
class User {
  Id id = Isar.autoIncrement;
  String name;
  String password;
  String? pathSchedules;

  late List<ToDoModel> notes = [];

  final discipline = IsarLinks<Discipline>();

  final student = IsarLinks<Student>();

  User({required this.name, required this.password});
}

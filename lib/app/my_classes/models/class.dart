import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:isar/isar.dart';

part 'class.g.dart';

@Collection(accessor: 'classes')
class Classes {
  Id id = Isar.autoIncrement;
  late String name;

  final student = IsarLinks<Student>();

  @Backlink(to: 'classes')
  final discipline = IsarLinks<Discipline>();
}

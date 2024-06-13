import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/user/user.dart';

import 'package:isar/isar.dart';

part 'student.g.dart';

@Collection(accessor: 'student')
class Student {
  Id id = Isar.autoIncrement;
  late String name;

  List<double?> grades = [null, null, null];
  List<double?> revaluations = [null, null, null];
  double? finalRevaluation;

  @Backlink(to: 'student')
  final user = IsarLink<User>();

  @Backlink(to: 'student')
  final classes = IsarLink<Classes>();
}

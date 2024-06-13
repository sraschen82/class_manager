import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/user/user.dart';
import 'package:isar/isar.dart';

part 'discipline.g.dart';

@Collection(accessor: 'discipline')
class Discipline {
  Id id = Isar.autoIncrement;
  late String name;

  final classes = IsarLinks<Classes>();

  @Backlink(to: 'discipline')
  final user = IsarLink<User>();

  // get classes() =>
}

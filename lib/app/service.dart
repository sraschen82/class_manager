import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';

List<Classes> getDisciplineClasses(
    {required Discipline? discipline, required List<Classes> allClasses}) {
  List<Classes> classes = [];
  if (discipline != null) {
    classes.addAll(allClasses);
    classes.retainWhere(
      (element) => element.discipline.contains(discipline),
    );
    classes.sort(
      (a, b) => a.name.compareTo(b.name),
    );
  }
  return classes;
}

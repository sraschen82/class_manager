import 'dart:math';

import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';

class Stats {
  static int countStudents(Classes oneClass) => oneClass.student.countSync();

  static int countReEvStudents(Classes oneClass, int tri) {
    Classes inClass = oneClass;
    inClass.student.retainWhere(
        (element) => element.grades[tri] != null && element.grades[tri]! < 6);
    return inClass.student.length;
  }

  static double percentReEvStudents(Classes oneClass, int tri) =>
      (Stats.countReEvStudents(oneClass, tri) / oneClass.student.countSync()) *
      100;

  static double average(
    List<Student> students,
    int tri,
  ) {
    double sum = 0;
    for (var element in students) {
      if (element.grades[tri] != null) {
        sum += element.grades[tri]!;
      }
    }

    students.retainWhere((element) => element.grades[tri] != null);
    return (sum / students.length);
  }

  static double stDev(List<Student> students, int tri) {
    double sum = 0;
    double average = Stats.average(students, tri);

    for (var element in students) {
      if (element.grades[tri] != null) {
        sum += pow(element.grades[tri]! - average, 2);
      }
    }

    students.retainWhere((element) => element.grades[tri] != null);

    return pow(sum / students.length, .5).toDouble();
  }

  static double cv(List<Student> students, int tri) =>
      (Stats.stDev(students, tri) / Stats.average(students.toList(), tri)) *
      100;

  static int getIntervalFrequency(
      {required Classes selectedClass,
      required int tri,
      required int lowerLimit}) {
    List<Student> students = [];
    students.addAll(selectedClass.student);

    students.removeWhere((element) =>
        element.grades[tri] == null || element.grades[tri]! < lowerLimit);

    if (lowerLimit != 8) {
      students
          .removeWhere((element) => element.grades[tri]! >= (lowerLimit + 2));
    }

    return students.length;
  }

  static int getCumulativeFrequency(
      {required Classes selectedClass,
      required int tri,
      required int lowerLimit}) {
    List<Student> students = [];
    students.addAll(selectedClass.student);

    lowerLimit != 8
        ? {
            students.removeWhere((element) =>
                element.grades[tri] == null ||
                element.grades[tri]! >= lowerLimit + 2)
          }
        : students.removeWhere((element) => element.grades[tri] == null);

    return students.length;
  }
}

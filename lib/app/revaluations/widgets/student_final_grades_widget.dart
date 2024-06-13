import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:flutter/material.dart';

class StudentGradesWidget extends StatelessWidget {
  final Student student;
  const StudentGradesWidget({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    checkGrades(int trim) {
      double? grade;
      if (student.grades.elementAt(trim) != null &&
          student.revaluations.elementAt(trim) != null) {
        student.grades.elementAt(trim)! >= student.revaluations.elementAt(trim)!
            ? grade = student.grades.elementAt(trim)!
            : grade = student.revaluations.elementAt(trim)!;
      } else if (student.grades.elementAt(trim) != null &&
          student.grades.elementAt(trim)! >= 6) {
        grade = student.grades.elementAt(trim)!;
      }
      return grade;
    }

    return Text(
      '${checkGrades(0) ?? '___'} | ${checkGrades(1) ?? '___'} | ${checkGrades(2) ?? '___'}',
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}

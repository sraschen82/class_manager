import 'dart:async';

import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:flutter/material.dart';

Future<void> setGradeDialog(
    BuildContext context, Student student, int index, bool isGrade) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(child: Text('SELECT ONE GRADE')),
          content: SingleChildScrollView(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 380,
                  width: 300,
                  decoration: BoxDecoration(
                      gradient: MyColors().gradientBackground_2()),
                  child: GridView.builder(
                    itemCount: 21,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 2,
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, indexGV) {
                      return SizedBox(
                        height: 8,
                        width: 12,
                        child: Card(
                          color: indexGV > 8 ? Colors.red : Colors.blueAccent,
                          elevation: 15,
                          child: TextButton(
                              onPressed: () {
                                backToEdictStudentAtom.setValue(true);

                                isGrade
                                    ? {
                                        (10 - indexGV.toDouble() * 0.5) < 6
                                            ? {
                                                student.grades[index] = (10 -
                                                    indexGV.toDouble() * 0.5),
                                                editStudentAction
                                                    .setValue(student),
                                                Timer(
                                                    const Duration(
                                                        milliseconds: 200), () {
                                                  selectedStudentAtom
                                                      .setValue(student);
                                                  Navigator.pop(context);
                                                }),
                                              }
                                            : {
                                                student.grades[index] = (10 -
                                                    indexGV.toDouble() * 0.5),
                                                student.revaluations[index] =
                                                    null,
                                                editStudentAction
                                                    .setValue(student),
                                                Timer(
                                                    const Duration(
                                                        milliseconds: 200), () {
                                                  selectedStudentAtom
                                                      .setValue(student);
                                                  Navigator.pop(context);
                                                }),
                                              }
                                      }
                                    : {
                                        student.revaluations[index] =
                                            (10 - indexGV.toDouble() * 0.5),
                                        editStudentAction.setValue(student),
                                        Navigator.pop(context),
                                      };
                              },
                              child: Text(
                                '${10 - indexGV.toDouble() * 0.5}',
                                style: const TextStyle(fontSize: 12),
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                isGrade
                    ? student.grades[index] = null
                    : student.revaluations[index] = null;
                backToEdictStudentAtom.setValue(true);
                editStudentAction.setValue(student);

                Navigator.pop(context);
              },
              child: const Text('Empty'),
            ),
          ],
        );
      });
}

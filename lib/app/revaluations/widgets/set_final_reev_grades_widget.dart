import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';

import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:flutter/material.dart';

Future<void> setFinalGradesDialog(
    BuildContext context, List<Student> students, int i, bool isEdit) async {
  TextEditingController controller = TextEditingController();

  if (!isEdit) {
    students.removeWhere((student) => student.finalRevaluation != null);
    students.sort(
      (a, b) => a.classes.value!.name.compareTo(b.classes.value!.name),
    );
  }

  validateForm(Student student, String stringGrade, int index) {
    Student newStudent = student;
    if (stringGrade.isNotEmpty) {
      stringGrade = stringGrade.replaceAll(',', '.');

      double grade = double.parse(stringGrade);
      if (grade <= 10 && grade >= 0) {
        newStudent.finalRevaluation = grade;
        editStudentAction.setValue(newStudent);

        index < students.length - 1
            ? {
                Navigator.pop(context),
                setFinalGradesDialog(context, students, index, isEdit)
              }
            : Navigator.pop(context);
      } else {
        Navigator.pop(context);
        setFinalGradesDialog(context, students, index, isEdit);
      }
    }
  }

  if (students.isNotEmpty) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('FINAL GRADE'),
                Column(
                  children: [
                    Text(
                      students[i].classes.value!.name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      students[i].name,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: SizedBox(
                        width: 120,
                        child: TextField(
                          autofocus: true,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.send,
                          onTap: () {},
                          maxLines: 1,
                          maxLength: 3,
                          showCursor: true,
                          controller: controller,
                          cursorColor: Colors.white,
                          onSubmitted: (value) {
                            validateForm(students[i], value, i);
                          },
                          style: const TextStyle(
                              decorationStyle: TextDecorationStyle.solid,
                              decorationColor:
                                  Color.fromARGB(255, 233, 219, 219),
                              color: Colors.white,
                              wordSpacing: 2),
                          decoration: const InputDecoration(
                              alignLabelWithHint: true,
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              labelText: 'Final Grade',
                              fillColor: Colors.white,
                              counterStyle: TextStyle(color: Colors.white),
                              floatingLabelStyle:
                                  TextStyle(color: Colors.white),
                              contentPadding: EdgeInsets.all(5),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                color: Colors.white,
                              )),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                ),
                                gapPadding: 4,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                onPressed: () {
                  students[i].finalRevaluation = null;

                  editStudentAction.setValue(students[i]);

                  i < students.length - 1
                      ? {
                          Navigator.pop(context),
                          setFinalGradesDialog(
                              context, students, (i + 1), isEdit),
                        }
                      : {
                          Navigator.pop(context),
                        };
                },
                child: const Text('Empy'),
              ),
              TextButton(
                onPressed: () {
                  validateForm(students[i], controller.text, i);
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[300]),
                ),
              ),
            ],
          );
        });
  } else {}
}

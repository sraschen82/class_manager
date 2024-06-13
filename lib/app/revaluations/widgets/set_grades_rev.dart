import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/home_page/atoms/page_status_atoms.dart';
import 'package:class_manager_two/app/home_page/home_page_states.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:flutter/material.dart';

Future<void> setReEvaluationsGradeDialog(BuildContext context,
    List<Student> students, int grade, int index, bool isReEvaluation) async {
  students.sort(
    (a, b) => a.classes.value!.name.compareTo(b.classes.value!.name),
  );

  int classLength = students.length;

  if (isReEvaluation == true) {
    students.retainWhere((element) => element.revaluations[grade] == null);
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
                Text('Re-evaluation - ${grade + 1}º TRI'),
                if (students[index].name.isNotEmpty)
                  Column(
                    children: [
                      Text(
                        students[index].classes.value!.name,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Text(
                        students[index].name,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
              ],
            )),
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
                                onPressed: () async {
                                  isReEvaluation
                                      ? students[index].revaluations[grade] =
                                          (10 - indexGV.toDouble() * 0.5)
                                      : students[index].grades[grade] =
                                          (10 - indexGV.toDouble() * 0.5);

                                  editStudentAction.setValue(students[index]);
                                  index < classLength - 1
                                      ? {
                                          Navigator.pop(context),
                                          setReEvaluationsGradeDialog(
                                              context,
                                              students,
                                              grade,
                                              index,
                                              isReEvaluation),
                                        }
                                      : {
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
                  students[index].revaluations[grade] = null;
                  editStudentAction.setValue(students[index]);
                  index < classLength - 1
                      ? {
                          index++,
                          Navigator.pop(context),
                          setReEvaluationsGradeDialog(
                              context, students, grade, index, isReEvaluation),
                        }
                      : {
                          Navigator.pop(context),
                          pageStatusAtom.setValue(PageStates.REVALUATION),
                        };
                },
                child: const Text('Empy'),
              ),
            ],
          );
        });
  } else {}
}

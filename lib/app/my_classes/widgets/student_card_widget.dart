import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_page_atoms.dart';
import 'package:class_manager_two/app/my_classes/class_routes.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class StudentCardWidget extends StatelessWidget {
  final int index;
  final Student student;
  const StudentCardWidget(
      {super.key, required this.index, required this.student});

  @override
  Widget build(BuildContext context) {
    Widget gradesWidget(String text, int index) {
      return Row(
        children: [
          Text(text),
          if (student.grades[index] == null) const Text(''),
          if (student.grades[index] != null)
            Text('  ${student.grades[index]}  '),
          if (student.revaluations[index] != null)
            Text('|  ${student.revaluations[index]}')
        ],
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: MyColors().gradientHomePage(),
          border: Border.all(
            color: Colors.white,
            style: BorderStyle.solid,
            strokeAlign: BorderSide.strokeAlignInside,
          )),
      child: SizedBox(
        height: 300,
        width: 300,
        child: Stack(
          children: [
            Column(
              children: [
                Slidable(
                  key: Key('$index'),
                  startActionPane: ActionPane(
                    motion: const DrawerMotion(),
                    closeThreshold: 0.1,
                    openThreshold: 0.1,
                    children: [
                      SlidableAction(
                        onPressed: (_) =>
                            deleteStudentAction.setValue(student.id),
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        borderRadius: BorderRadius.circular(15),
                        padding: const EdgeInsets.all(2),
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          selectedStudentAtom.setValue(student);
                          classPageAtom.setValue(ClassPageStatus.EDIT_STUDENT);
                        },
                        backgroundColor: const Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        borderRadius: BorderRadius.circular(15),
                        padding: const EdgeInsets.all(2),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: 290,
                    child: SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                      child: Text('  ${index + 1}.  ${student.name}'),
                    )),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  indent: 10,
                  endIndent: 10,
                  height: 5,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 70, 3, 30),
              child: Align(
                alignment: const Alignment(0, -0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    gradesWidget('1º TRI', 0),
                    gradesWidget('2º TRI', 1),
                    gradesWidget('3º TRI', 2),
                    if (student.finalRevaluation != null)
                      Row(
                        children: [
                          const Text('Final Revaluation: '),
                          Text('|  ${student.finalRevaluation}')
                        ],
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

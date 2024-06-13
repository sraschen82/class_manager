import 'package:asp/asp.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/revaluations/widgets/set_grades_rev.dart';
import 'package:flutter/material.dart';

class EmptyGradesListWidget extends StatelessWidget {
  final int trim;
  const EmptyGradesListWidget({super.key, required this.trim});

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {
        userDisciplinesAtom,
        userClassesAtom,
        userStudentsAtom,
        classErrorAtom,
        selectedDisciplineAtom,
      },
    );
    List<Student> emptyGradesList(int trim) {
      List<Student> list = userStudentsAtom.value
          .where((element) => element.grades[trim] == null)
          .toList();
      list.isNotEmpty
          ? {
              list.retainWhere((element) =>
                  selectedDisciplineAtom.value!.classes.any((classes) =>
                      classes.name == element.classes.value?.name)),
              list.sort((a, b) =>
                  a.classes.value!.name.compareTo(b.classes.value!.name)),
            }
          : list = [];
      return list;
    }

    if (emptyGradesList(trim).isNotEmpty) {
      return Card(
        color: Colors.black.withOpacity(.1),
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('--- Students without grades. ---'),
                  IconButton(
                    onPressed: () => setReEvaluationsGradeDialog(
                        context, emptyGradesList(trim), trim, 0, false),
                    icon: const Icon(Icons.upload_outlined),
                    iconSize: 20,
                    alignment: Alignment.topCenter,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35 * emptyGradesList(trim).length.toDouble(),
              child: ListView.builder(
                  itemCount: emptyGradesList(trim).length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        height: 30,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                              '${index + 1}. (${emptyGradesList(trim)[index].classes.value!.name})    ${emptyGradesList(trim)[index].name}'),
                        ));
                  }),
            ),
          ],
        ),
      );
    }
    return const Text('');
  }
}

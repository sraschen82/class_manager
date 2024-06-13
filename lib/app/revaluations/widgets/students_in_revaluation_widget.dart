import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/revaluations/widgets/empty_grades_widget.dart';
import 'package:class_manager_two/app/revaluations/widgets/set_grades_rev.dart';
import 'package:flutter/material.dart';

Widget studentsInRevaluationWidget(
  int trim,
  BuildContext context,
) {
  selectStudentsInRevaluations(int classIndex, int trim) {
    List<Student> list = userStudentsAtom.value
        .where(
          (element) =>
              element.classes.value?.id ==
              userClassesAtom.value
                  .where((element) =>
                      element.discipline.contains(selectedDisciplineAtom.value))
                  .elementAt(classIndex)
                  .id,
        )
        .toList();
    list.isNotEmpty
        ? {
            list.removeWhere((element) =>
                element.grades.elementAt(trim) == null ||
                element.grades.elementAt(trim)! >= 6),
            list.sort((a, b) => a.name.compareTo(b.name)),
          }
        : list = [];

    return list;
  }

  List<Student> studentsInReEvaluation() {
    List<Student> list = [];

    int classNumber = userClassesAtom.value
        .where((element) =>
            element.discipline.contains(selectedDisciplineAtom.value))
        .length;

    for (int i = 0; i < classNumber; i++) {
      list.addAll(selectStudentsInRevaluations(i, trim));
    }
    return list;
  }

  return Card(
    elevation: 15,
    color: const Color.fromARGB(255, 163, 13, 3),
    child: FractionallySizedBox(
        widthFactor: .97,
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.black, width: 3),
                  gradient: MyColors().gradientBackground_4()),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      width: 60,
                    ),
                    SizedBox(
                      width: 60,
                      child: Text(
                        '${trim + 1}º TRI',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: IconButton(
                          onPressed: () => setReEvaluationsGradeDialog(
                              context, studentsInReEvaluation(), trim, 0, true),
                          icon: const Icon(Icons.upload_outlined)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .71,
              child: ListView.builder(
                  // addAutomaticKeepAlives: true,
                  // addRepaintBoundaries: true,
                  // shrinkWrap: true,
                  itemCount: userClassesAtom.value
                          .where((element) => element.discipline
                              .contains(selectedDisciplineAtom.value))
                          .length +
                      1,
                  itemBuilder: (context, indexC) {
                    if (indexC ==
                        userClassesAtom.value
                            .where((element) => element.discipline
                                .contains(selectedDisciplineAtom.value))
                            .length) {
                      return EmptyGradesListWidget(trim: trim);
                    }
                    if (selectStudentsInRevaluations(indexC, trim).isNotEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Card(
                                margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(80, 5, 80, 5),
                                  child: Text(
                                    userClassesAtom.value
                                        .where((element) => element.discipline
                                            .contains(
                                                selectedDisciplineAtom.value))
                                        .elementAt(indexC)
                                        .name,
                                    style: TextStyle(color: Colors.red[900]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                // height: (50 *
                                //         selectStudentsInRevaluations(
                                //                 indexC, trim)
                                //             .length)
                                //     .toDouble(),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    addAutomaticKeepAlives: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: selectStudentsInRevaluations(
                                            indexC, trim)
                                        .length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        dense: true,
                                        visualDensity: VisualDensity.compact,
                                        title: Text(
                                          '${index + 1}. ${selectStudentsInRevaluations(indexC, trim)[index].name}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        trailing: selectStudentsInRevaluations(
                                                        indexC, trim)[index]
                                                    .revaluations
                                                    .elementAt(trim) ==
                                                null
                                            ? TextButton(
                                                onPressed: () =>
                                                    setReEvaluationsGradeDialog(
                                                        context,
                                                        [
                                                          selectStudentsInRevaluations(
                                                              indexC,
                                                              trim)[index]
                                                        ],
                                                        trim,
                                                        0,
                                                        true),
                                                child: Text(
                                                  '${selectStudentsInRevaluations(indexC, trim)[index].grades.elementAt(trim)}  ',
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 238, 200, 85),
                                                      fontSize: 12),
                                                ),
                                              )
                                            : Text(
                                                '${selectStudentsInRevaluations(indexC, trim)[index].grades.elementAt(trim)} | ${selectStudentsInRevaluations(indexC, trim)[index].revaluations.elementAt(trim)}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                      );
                                    }),
                              ),
                              const Divider(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return null;
                  }),
            ),
          ],
        )),
  );
}

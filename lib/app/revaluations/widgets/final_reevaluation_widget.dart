import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/revaluations/widgets/set_final_reev_grades_widget.dart';
import 'package:class_manager_two/app/revaluations/widgets/student_final_grades_widget.dart';
import 'package:flutter/material.dart';

Widget finalRevaluationWidget(
  BuildContext context,
) {
  selectStudentsInFinalRevaluations(int classIndex) {
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
            list.retainWhere((element) => element.revaluations
                .any((grade) => grade != null && grade < 6)),
            list.sort((a, b) => a.name.compareTo(b.name)),
          }
        : list = [];

    return list;
  }

  List<Student> studentsInFinalReEvaluation() {
    List<Student> list = [];

    int classNumber = userClassesAtom.value
        .where((element) =>
            element.discipline.contains(selectedDisciplineAtom.value))
        .length;

    for (int i = 0; i < classNumber; i++) {
      list.addAll(selectStudentsInFinalRevaluations(i));
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
                      width: 180,
                      child: Text(
                        'FINAL REVALUATION',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: IconButton(
                          onPressed: () => setFinalGradesDialog(
                              context, studentsInFinalReEvaluation(), 0, false),
                          icon: const Icon(Icons.upload_outlined)),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .71,
              child: ListView.builder(
                  addAutomaticKeepAlives: true,
                  addRepaintBoundaries: true,
                  shrinkWrap: true,
                  itemCount: userClassesAtom.value
                      .where((element) => element.discipline
                          .contains(selectedDisciplineAtom.value))
                      .length,
                  itemBuilder: (context, indexC) {
                    if (selectStudentsInFinalRevaluations(indexC).isNotEmpty) {
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
                                // height: (100 *
                                //         selectStudentsInFinalRevaluations(
                                //                 indexC)
                                //             .length)
                                //     .toDouble(),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    addAutomaticKeepAlives: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        selectStudentsInFinalRevaluations(
                                                indexC)
                                            .length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        dense: true,
                                        visualDensity: VisualDensity.compact,
                                        title: Text(
                                          '${index + 1}. ${selectStudentsInFinalRevaluations(indexC)[index].name}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        subtitle: selectStudentsInFinalRevaluations(
                                                    indexC)[index]
                                                .revaluations
                                                .any((element) =>
                                                    element != null ||
                                                    selectStudentsInFinalRevaluations(
                                                                indexC)[index]
                                                            .grades
                                                            .elementAt(selectStudentsInFinalRevaluations(
                                                                        indexC)[
                                                                    index]
                                                                .revaluations
                                                                .indexOf(
                                                                    element))! >=
                                                        6)
                                            ? Row(
                                                children: [
                                                  const Text(
                                                    '     Final: ',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  selectStudentsInFinalRevaluations(
                                                                  indexC)[index]
                                                              .finalRevaluation ==
                                                          null
                                                      ? SizedBox(
                                                          width: 60,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                setFinalGradesDialog(
                                                                    context,
                                                                    [
                                                                      selectStudentsInFinalRevaluations(
                                                                              indexC)[
                                                                          index]
                                                                    ],
                                                                    0,
                                                                    true);
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .upload_outlined,
                                                                size: 12,
                                                                color: Colors
                                                                    .white,
                                                              )),
                                                        )
                                                      : TextButton(
                                                          style: const ButtonStyle(
                                                              alignment: Alignment
                                                                  .centerLeft),
                                                          onPressed: () {
                                                            setFinalGradesDialog(
                                                                context,
                                                                [
                                                                  selectStudentsInFinalRevaluations(
                                                                          indexC)[
                                                                      index]
                                                                ],
                                                                0,
                                                                true);
                                                          },
                                                          child: Text(
                                                            ' ${selectStudentsInFinalRevaluations(indexC)[index].finalRevaluation ?? ''}',
                                                            style: TextStyle(
                                                                color: selectStudentsInFinalRevaluations(indexC)[index]
                                                                            .finalRevaluation! >=
                                                                        5
                                                                    ? Colors.blue[
                                                                        400]
                                                                    : Colors.red[
                                                                        200]),
                                                          )),
                                                ],
                                              )
                                            : const Text(''),
                                        trailing: StudentGradesWidget(
                                          student:
                                              selectStudentsInFinalRevaluations(
                                                  indexC)[index],
                                        ),
                                      );
                                    }),
                              ),
                              const Divider(
                                height: 5,
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

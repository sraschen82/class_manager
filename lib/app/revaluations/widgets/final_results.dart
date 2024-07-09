import 'package:asp/asp.dart';
import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/revaluations/widgets/student_final_grades_widget.dart';
import 'package:flutter/material.dart';

class FinalResults extends StatefulWidget {
  final BuildContext context;
  const FinalResults({super.key, required this.context});

  @override
  State<FinalResults> createState() => _FinalResultsState();
}

class _FinalResultsState extends State<FinalResults> {
  @override
  Widget build(BuildContext context) {
    context.select(
      () => {
        userClassesAtom,
        selectedDisciplineAtom,
      },
    );

    List<Student> finalGradesStudents(List<Classes> classes, int classId) {
      List<Student> students = [];
      Classes inClass = classes.firstWhere((element) => element.id == classId);
      for (var element in inClass.student) {
        if (element.finalRevaluation != null) {
          students.add(element);
        }
      }
      return students;
    }

    final List<Classes> classesList = userClassesAtom.value;
    classesList.retainWhere(
        (element) => element.discipline.contains(selectedDisciplineAtom.value));
    classesList.sort((a, b) => a.name.compareTo(b.name));

    List<String> title = ['Approved', 'Disapproved'];

    List<Student> students = [];

    for (int i = 0; i < classesList.length; i++) {
      students.addAll(
          finalGradesStudents(userClassesAtom.value, classesList[i].id));
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
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: Text(
                        'FINAL RESULTS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .71,
                child: ListView.builder(
                    addAutomaticKeepAlives: true,
                    addRepaintBoundaries: true,
                    shrinkWrap: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
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
                                    title[index],
                                    style: TextStyle(color: Colors.red[900]),
                                  ),
                                ),
                              ),
                              index == 0
                                  ? SizedBox(
                                      height: (60 *
                                              students
                                                  .where((element) =>
                                                      element.finalRevaluation !=
                                                          null &&
                                                      element.finalRevaluation! >=
                                                          5)
                                                  .length)
                                          .toDouble(),
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: students
                                              .where((element) =>
                                                  element.finalRevaluation !=
                                                      null &&
                                                  element.finalRevaluation! >=
                                                      5)
                                              .length,
                                          itemBuilder: (context, indexS) {
                                            return ListTile(
                                              dense: true,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              title: Text(
                                                '${indexS + 1}. (${students.where((element) => element.finalRevaluation != null && element.finalRevaluation! >= 5).elementAt(indexS).classes.value!.name})   ${students.where((element) => element.finalRevaluation != null && element.finalRevaluation! >= 5).elementAt(indexS).name}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50),
                                                child: StudentGradesWidget(
                                                  student: students
                                                      .where((element) =>
                                                          element.finalRevaluation !=
                                                              null &&
                                                          element.finalRevaluation! >=
                                                              5)
                                                      .elementAt(indexS),
                                                ),
                                              ),
                                              trailing: Text(
                                                '${students.where((element) => element.finalRevaluation != null && element.finalRevaluation! >= 5).elementAt(indexS).finalRevaluation}',
                                                style: TextStyle(
                                                    color: Colors.blue[400],
                                                    fontSize: 14),
                                              ),
                                            );
                                          }),
                                    )
                                  : SizedBox(
                                      height: (60 *
                                              students
                                                  .where((element) =>
                                                      element.finalRevaluation !=
                                                          null &&
                                                      element.finalRevaluation! <
                                                          5)
                                                  .length)
                                          .toDouble(),
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: students
                                              .where((element) =>
                                                  element.finalRevaluation !=
                                                      null &&
                                                  element.finalRevaluation! < 5)
                                              .length,
                                          itemBuilder: (context, indexS) {
                                            return ListTile(
                                              dense: true,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              title: Text(
                                                '${indexS + 1}. (${students.where((element) => element.finalRevaluation != null && element.finalRevaluation! < 5).elementAt(indexS).classes.value!.name})   ${students.where((element) => element.finalRevaluation != null && element.finalRevaluation! < 5).elementAt(indexS).name}',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50),
                                                child: StudentGradesWidget(
                                                  student: students
                                                      .where((element) =>
                                                          element.finalRevaluation !=
                                                              null &&
                                                          element.finalRevaluation! <
                                                              5)
                                                      .elementAt(indexS),
                                                ),
                                              ),
                                              trailing: Text(
                                                '${students.where((element) => element.finalRevaluation != null && element.finalRevaluation! < 5).elementAt(indexS).finalRevaluation}',
                                                style: TextStyle(
                                                    color: Colors.red[200],
                                                    fontSize: 14),
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
                    }),
              ),
            ],
          )),
    );
  }
}

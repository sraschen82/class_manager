import 'package:asp/asp.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/service.dart';
import 'package:class_manager_two/app/statistics/charts/chart_line_allclasses.dart';
import 'package:class_manager_two/app/statistics/widgets/charts_class_widget.dart';
import 'package:flutter/material.dart';

class ChartsWidget extends StatelessWidget {
  const ChartsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    context.select(
      () => {
        userDisciplinesAtom,
        userClassesAtom,
        userStudentsAtom,
        selectedDisciplineAtom,
      },
    );

    List<Classes> classes = getDisciplineClasses(
        discipline: selectedDisciplineAtom.value,
        allClasses: userClassesAtom.value);

    List<Widget> getList() {
      return List.generate(
        classes.length,
        (index) {
          return Row(
            children: [
              Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: ChartClassWidget(
                      discipline: selectedDisciplineAtom.value!,
                      selectedClass: classes[index],
                    ),
                  )),
            ],
          );
        },
      ).toList();
    }

    return Card(
        elevation: 15,
        color: const Color.fromARGB(255, 163, 13, 3),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * .70,
          width: MediaQuery.of(context).size.width * .97,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: selectedDisciplineAtom.value!.classes.isNotEmpty
                            ? ChartLineAllClasses(
                                discipline: selectedDisciplineAtom.value!,
                                tri: 0,
                              )
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: selectedDisciplineAtom.value!.classes.isNotEmpty
                            ? ChartLineAllClasses(
                                discipline: selectedDisciplineAtom.value!,
                                tri: 1,
                              )
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: selectedDisciplineAtom.value!.classes.isNotEmpty
                            ? ChartLineAllClasses(
                                discipline: selectedDisciplineAtom.value!,
                                tri: 2,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: getList(),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:asp/asp.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/service.dart';
import 'package:class_manager_two/app/statistics/tables/table_interval_class_distrib.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FrequencyDistributionWidget extends StatelessWidget {
  int tri;
  FrequencyDistributionWidget({super.key, required this.tri});

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
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                      child: ClassIntervalsTable(
                    theClass: classes[index],
                    tri: tri,
                  ))),
            ],
          );
        },
      ).toList();
    }

    return Card(
        elevation: 15,
        color: const Color.fromARGB(255, 163, 13, 3),
        child: Column(
          children: getList(),
        ));
  }
}

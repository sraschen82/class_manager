import 'package:asp/asp.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/statistics/stats_class.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReEvaluationsAnalysisTable extends StatelessWidget {
  final List<Classes> classes;
  final int tri;
  const ReEvaluationsAnalysisTable(
      {super.key, required this.classes, required this.tri});

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

    selectStudentsInRevaluations(int classIndex, int trim) {
      List<Student> list = userStudentsAtom.value
          .where(
            (element) =>
                element.classes.value?.id ==
                userClassesAtom.value
                    .where((element) => element.discipline
                        .contains(selectedDisciplineAtom.value))
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

    List<DataColumn> columns() {
      return [
        DataColumn(
            label: Center(
          child: Text('${tri + 1}º TRI'),
        )),
        const DataColumn(label: Center(child: Text('Std'))),
        const DataColumn(label: Center(child: Text('Ave'))),
        const DataColumn(
          label: Center(child: Text('CV')),
        ),
      ];
    }

    List<DataRow> rows() {
      return List.generate(
          classes.length,
          (index) => DataRow(cells: [
                DataCell(
                  Center(
                    child: Text(
                      classes[index].name,
                      maxLines: 1,
                      textScaler: classes[index].name.length <= 6
                          ? const TextScaler.linear(1)
                          : TextScaler.linear(6 / classes[index].name.length),
                    ),
                  ),
                ),
                DataCell(Center(
                    child: selectStudentsInRevaluations(index, tri).isNotEmpty
                        ? Text(
                            '${selectStudentsInRevaluations(index, tri).length}')
                        : const Text(''))),
                DataCell(Center(
                    child: selectStudentsInRevaluations(index, tri).isNotEmpty
                        ? Text(Stats.average(
                                selectStudentsInRevaluations(index, tri), tri)
                            .toStringAsFixed(2))
                        : const Text(''))),
                DataCell(Center(
                    child: selectStudentsInRevaluations(index, tri).isNotEmpty
                        ? Text(
                            '${Stats.cv(selectStudentsInRevaluations(index, tri), tri).toStringAsFixed(0)}%')
                        : const Text(''))),
              ]));
    }

    return DataTable(
      columns: columns(),
      rows: rows(),
      columnSpacing: 70,
      border: TableBorder.all(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      headingRowColor:
          const MaterialStatePropertyAll(Color.fromARGB(255, 11, 9, 119)),
      dataRowColor:
          const MaterialStatePropertyAll(Color.fromARGB(255, 41, 38, 173)),
      horizontalMargin: 15,
    );
  }
}

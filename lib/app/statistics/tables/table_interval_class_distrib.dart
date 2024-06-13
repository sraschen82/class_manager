import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/statistics/stats_class.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ClassIntervalsTable extends StatelessWidget {
  Classes theClass;
  int tri;
  ClassIntervalsTable({super.key, required this.theClass, required this.tri});

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns() {
      return [
        DataColumn(
            label: Center(
          child: Text('${theClass.name} - ${tri + 1}º TRI'),
        )),
        const DataColumn(label: Center(child: Text('f'))),
        const DataColumn(label: Center(child: Text('fr'))),
        const DataColumn(
          label: Center(child: Text('F')),
        ),
        const DataColumn(
          label: Center(child: Text('Fr')),
        ),
      ];
    }

    List<DataRow> rows() {
      return List.generate(5, (index) {
        return DataRow(cells: [
          DataCell(
            Center(
              child: index == 4
                  ? Text('   ${2 * index}  |----| ${2 * index + 2}')
                  : Text('${2 * index}  |----  ${2 * index + 2}'),
            ),
          ),
          DataCell(
            Center(
                child: theClass.student
                        .any((element) => element.grades[tri] != null)
                    ? Text(
                        '${Stats.getIntervalFrequency(selectedClass: theClass, tri: tri, lowerLimit: 2 * index)}',
                      )
                    : const Text('')),
          ),
          DataCell(
            Center(
                child: theClass.student
                        .where((element) => element.grades[tri] != null)
                        .isEmpty
                    ? const Text('')
                    : Text(
                        '${(Stats.getIntervalFrequency(selectedClass: theClass, tri: tri, lowerLimit: 2 * index) / (theClass.student.where((element) => element.grades[tri] != null).length) * 100).toStringAsFixed(0)}%')),
          ),
          DataCell(
            Center(
                child: theClass.student
                        .any((element) => element.grades[tri] != null)
                    ? Text(
                        '${Stats.getCumulativeFrequency(selectedClass: theClass, tri: tri, lowerLimit: 2 * index)}')
                    : const Text('')),
          ),
          DataCell(Center(
            child: theClass.student
                    .where((element) => element.grades[tri] != null)
                    .isEmpty
                ? const Text('')
                : Text(
                    '${(Stats.getCumulativeFrequency(selectedClass: theClass, tri: tri, lowerLimit: 2 * index) / (theClass.student.where((element) => element.grades[tri] != null).length) * 100).toStringAsFixed(0)}%'),
          )),
        ]);
      });
    }

    return DataTable(
      columns: columns(),
      rows: rows(),
      columnSpacing: 40,
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

import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:flutter/material.dart';
import 'package:class_manager_two/app/statistics/stats_class.dart';

DataTable stDevTable(List<Classes> classes) {
  List<Student> filterStudentsClass(Classes myClass) {
    List<Student> studentsClass = [];
    studentsClass.addAll(userStudentsAtom.value);
    studentsClass
        .retainWhere((element) => element.classes.value!.id == myClass.id);

    return studentsClass;
  }

  List<DataColumn> columns() {
    return [
      const DataColumn(
        label: Text('StDev'),
      ),
      const DataColumn(
          label: Center(
        child: Text('1º TRI'),
      )),
      const DataColumn(label: Text('2º TRI')),
      const DataColumn(label: Text('3º TRI')),
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
                  child: Stats.stDev(filterStudentsClass(classes[index]), 0)
                          .isFinite
                      ? Text(Stats.stDev(
                          filterStudentsClass(classes[index]),
                          0,
                        ).toStringAsFixed(2))
                      : const Text(''))),
              DataCell(Center(
                  child: Stats.stDev(filterStudentsClass(classes[index]), 1)
                          .isFinite
                      ? Text(Stats.stDev(filterStudentsClass(classes[index]), 1)
                          .toStringAsFixed(2))
                      : const Text(''))),
              DataCell(Center(
                  child: Stats.stDev(filterStudentsClass(classes[index]), 2)
                          .isFinite
                      ? Text(Stats.stDev(filterStudentsClass(classes[index]), 2)
                          .toStringAsFixed(2))
                      : const Text(''))),
            ]));
  }

  return DataTable(
    columns: columns(),
    rows: rows(),
    border: TableBorder.all(
        color: Colors.white, borderRadius: BorderRadius.circular(5)),
    headingRowColor:
        const MaterialStatePropertyAll(Color.fromARGB(255, 11, 9, 119)),
    dataRowColor:
        const MaterialStatePropertyAll(Color.fromARGB(255, 41, 38, 173)),
    horizontalMargin: 15,
  );
}

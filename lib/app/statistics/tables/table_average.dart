import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/statistics/stats_class.dart';
import 'package:flutter/material.dart';

class AverageTable extends StatelessWidget {
  final List<Classes> classes;

  const AverageTable({super.key, required this.classes});

  List<Student> filterStudentsClass(Classes myClass) {
    List<Student> studentsClass = [];
    studentsClass.addAll(userStudentsAtom.value);
    studentsClass
        .retainWhere((element) => element.classes.value!.id == myClass.id);

    return studentsClass;
  }

  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns() {
      return [
        const DataColumn(
          label: Text('Average'),
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
                      classes.elementAt(index).name,
                      maxLines: 1,
                      textScaler: classes.elementAt(index).name.length <= 6
                          ? const TextScaler.linear(1)
                          : TextScaler.linear(
                              6 / classes.elementAt(index).name.length),
                    ),
                  ),
                ),
                DataCell(Center(
                    child:
                        // Text(Stats.average(
                        //         filterStudentsClass(classes.elementAt(index)), 0)
                        //     .toStringAsFixed(2)))),

                        Stats.average(
                                    filterStudentsClass(
                                        classes.elementAt(index)),
                                    0)
                                .isFinite
                            ? Text(Stats.average(
                                    filterStudentsClass(
                                        classes.elementAt(index)),
                                    0)
                                .toStringAsFixed(2))
                            : const Text(''))),
                DataCell(Center(
                    child: Stats.average(
                                filterStudentsClass(classes.elementAt(index)),
                                1)
                            .isFinite
                        ? Text(Stats.average(
                                filterStudentsClass(classes.elementAt(index)),
                                1)
                            .toStringAsFixed(2))
                        : const Text(''))),
                DataCell(Center(
                    child: Stats.average(
                                filterStudentsClass(classes.elementAt(index)),
                                2)
                            .isFinite
                        ? Text(Stats.average(
                                filterStudentsClass(classes.elementAt(index)),
                                2)
                            .toStringAsFixed(2))
                        : const Text(''))),
              ]));
    }

    return DataTable(
      columns: columns(),
      rows: rows(),
      columnSpacing: 52,
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



  

 

// DataTable averageTable(List<Classes> classes) {
//   print('---------- averageTable ${classes.length}');
//   print('---------- averageTable ${classes[0].student.countSync()}');

//   List<DataColumn> columns() {
//     return [
//       const DataColumn(
//         label: Text('Average'),
//       ),
//       const DataColumn(
//           label: Center(
//         child: Text('1º TRI'),
//       )),
//       const DataColumn(label: Text('2º TRI')),
//       const DataColumn(label: Text('3º TRI')),
//     ];
//   }

//   List<DataRow> rows() {
//     return List.generate(
//         classes.length,
//         (index) => DataRow(cells: [
//               DataCell(
//                 Center(
//                   child: Text(
//                     classes.elementAt(index).name,
//                     maxLines: 1,
//                     textScaler: classes.elementAt(index).name.length <= 6
//                         ? const TextScaler.linear(1)
//                         : TextScaler.linear(
//                             6 / classes.elementAt(index).name.length),
//                   ),
//                 ),
//               ),
//               DataCell(Center(
//                   child: Text(Stats.average(classes.elementAt(index), 0)
//                       .toStringAsFixed(2)))),

//               // Stats.average(classes[index], 0) != 0.00
//               //     ? Text(Stats.average(classes.elementAt(index), 0)
//               //         .toStringAsFixed(2))
//               //     : const Text(''))),
//               DataCell(Center(
//                   child: Stats.average(classes.elementAt(index), 1) != 0.00
//                       ? Text(Stats.average(classes.elementAt(index), 1)
//                           .toStringAsFixed(2))
//                       : const Text(''))),
//               DataCell(Center(
//                   child: Stats.average(classes.elementAt(index), 2) != 0.00
//                       ? Text(Stats.average(classes.elementAt(index), 2)
//                           .toStringAsFixed(2))
//                       : const Text(''))),
//             ]));
//   }

//   return DataTable(
//     columns: columns(),
//     rows: rows(),
//     columnSpacing: 52,
//     border: TableBorder.all(
//         color: Colors.white, borderRadius: BorderRadius.circular(5)),
//     headingRowColor:
//         const MaterialStatePropertyAll(Color.fromARGB(255, 11, 9, 119)),
//     dataRowColor:
//         const MaterialStatePropertyAll(Color.fromARGB(255, 41, 38, 173)),
//     horizontalMargin: 15,
//   );
// }

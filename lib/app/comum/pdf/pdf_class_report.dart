import 'dart:io';

import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/service.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfClassReport {
  Future<File> createPDF({required String fileName}) async {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        header: _header,
        footer: _footer,
        pageFormat: PdfPageFormat.a4,
        build: (context) => _buildContent(context)));

    final String dir = (await getApplicationDocumentsDirectory()).path;

    final String path = '$dir/$fileName.pdf';
    final File file = File(path);

    await file.writeAsBytes(await pdf.save());

    return file;
  }

  pw.Widget _header(pw.Context context) {
    return pw.Container(
        height: 30,
        child: pw.Center(
          child: pw.Text(
            'Class Report - ${selectedDisciplineAtom.value!.name}',
            style: const pw.TextStyle(
              fontSize: 20,
            ),
          ),
        ));
  }

  pw.Widget _footer(pw.Context context) {
    return pw.Container(
        height: 30,
        child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
            children: [
              pw.Text('Class Manager II - Developed by @sraschen'),
              pw.Text(
                  DateFormat('dd/MM/yyyy  kk:mm:ss').format(DateTime.now())),
            ]));
  }

  _buildContent(pw.Context context) => pdfPages();
}

List<pw.Widget> pdfPages() {
  List<Classes> classesList = getDisciplineClasses(
    discipline: selectedDisciplineAtom.value,
    allClasses: userClassesAtom.value,
  );
  List<pw.Widget> listWidget = [];
  for (var disciplineClass in classesList) {
    listWidget.add(pdfPageInfo(disciplineClass));
  }
  return listWidget;
}

pw.Widget pdfPageInfo(Classes disciplineClass) {
  List<Student> classStudents = disciplineClass.student.toList();
  if (classStudents.isNotEmpty) {
    classStudents.sort(
      (a, b) => a.name.compareTo(b.name),
    );
  }
  return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      height: PdfPageFormat.a4.availableHeight * .9,
      width: PdfPageFormat.a4.availableWidth * .98,
      child: pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Column(children: [
            pw.Text('Class ${disciplineClass.name}',
                style: const pw.TextStyle(fontSize: 15)),
            pw.Divider(),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.SizedBox(
                    width: 120,
                    child: pw.Text(
                      '                            NAME',
                      style: const pw.TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            '1º TRI',
                            style: const pw.TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            '2º TRI',
                            style: const pw.TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                        pw.SizedBox(
                          width: 50,
                          child: pw.Text(
                            '3º TRI',
                            style: const pw.TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                        pw.SizedBox(
                          width: 40,
                          child: pw.Text(
                            '',
                            style: const pw.TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ]),
                ]),
            pw.Divider(height: 5),
            pw.ListView.builder(
              // spacing: 5,
              itemCount: classStudents.length,
              itemBuilder: (context, index) {
                return pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text(
                              '${index + 1}. ${classStudents[index].name}',
                              style: const pw.TextStyle(
                                fontSize: 8,
                              ),
                            ),
                            pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceEvenly,
                                children: [
                                  pw.SizedBox(
                                    width: 50,
                                    child: pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            '${classStudents[index].grades[0] ?? '___'}',
                                            style: const pw.TextStyle(
                                              fontSize: 8,
                                            ),
                                          ),
                                          if (classStudents[index].grades[0] !=
                                                  null &&
                                              classStudents[index].grades[0]! <
                                                  6)
                                            pw.Text(
                                              ' | ${classStudents[index].revaluations[0] ?? '___'}',
                                              style: const pw.TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                        ]),
                                  ),
                                  pw.SizedBox(
                                    width: 50,
                                    child: pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            '${classStudents[index].grades[1] ?? '___'}',
                                            style: const pw.TextStyle(
                                              fontSize: 8,
                                            ),
                                          ),
                                          if (classStudents[index].grades[1] !=
                                                  null &&
                                              classStudents[index].grades[1]! <
                                                  6)
                                            pw.Text(
                                              ' | ${classStudents[index].revaluations[1] ?? '___'}',
                                              style: const pw.TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                        ]),
                                  ),
                                  pw.SizedBox(
                                    width: 50,
                                    child: pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            '${classStudents[index].grades[2] ?? '___'}',
                                            style: const pw.TextStyle(
                                              fontSize: 8,
                                            ),
                                          ),
                                          if (classStudents[index].grades[2] !=
                                                  null &&
                                              classStudents[index].grades[2]! <
                                                  6)
                                            pw.Text(
                                              ' | ${classStudents[index].revaluations[2] ?? '___'}',
                                              style: const pw.TextStyle(
                                                fontSize: 8,
                                              ),
                                            ),
                                        ]),
                                  ),
                                  pw.SizedBox(
                                    width: 50,
                                    child: pw.Center(
                                      child: classStudents[index]
                                              .revaluations
                                              .any((element) =>
                                                  element != null &&
                                                  element < 6)
                                          ? pw.Text(
                                              'Final: ${classStudents[index].finalRevaluation ?? '___'}',
                                              style: const pw.TextStyle(
                                                fontSize: 8,
                                              ),
                                            )
                                          : pw.Text(
                                              '',
                                              style: const pw.TextStyle(
                                                fontSize: 8,
                                              ),
                                              // child: pw.Text(
                                              //   'Final: ${classStudents[index].finalRevaluation ?? '___'}',
                                              //   style: const pw.TextStyle(
                                              //     fontSize: 8,
                                              //   ),
                                            ),
                                    ),
                                  ),
                                ]),
                          ]),
                      pw.Divider(height: 5),
                    ]);
              },
            )
          ])));
}

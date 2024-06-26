import 'dart:io';
import 'dart:ui';

import 'package:class_manager_two/app/auth/auth_atoms.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:class_manager_two/app/my_classes/models/class.dart';
import 'package:class_manager_two/app/my_classes/models/student.dart';
import 'package:class_manager_two/app/service.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfActivityWorkSheet {
  Future<File> createPDF({required String fileName}) async {
    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        // header: _header,
        // footer: _footer,
        pageFormat: PdfPageFormat.a4,
        build: (context) => _buildContent(context)));

    final String dir = (await getApplicationDocumentsDirectory()).path;

    final String path = '$dir/$fileName.pdf';
    final File file = File(path);

    await file.writeAsBytes(await pdf.save());

    return file;
  }

  // pw.Widget _header(pw.Context context) {
  //   return pw.Container(
  //       height: 30,
  //       child: pw.Center(
  //         child: pw.Text(
  //           'Class Report - ${selectedDisciplineAtom.value!.name}',
  //           style: const pw.TextStyle(
  //             fontSize: 20,
  //           ),
  //         ),
  //       ));
  // }

  // pw.Widget _footer(pw.Context context) {
  //   return pw.Container(
  //       height: 30,
  //       child: pw.Row(
  //           mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
  //           children: [
  //             pw.Text('Class Manager II - Developed by @sraschen'),
  //             pw.Text(
  //                 DateFormat('dd/MM/yyyy  kk:mm:ss').format(DateTime.now())),
  //           ]));
  // }

  _buildContent(pw.Context context) => pdfPages();
}

pw.Widget firstPage() {
  return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Container(
            height: PdfPageFormat.a4.availableHeight * .05,
            child: pw.Center(
              child: pw.Text(
                'Activity WorkSheet',
                style: const pw.TextStyle(
                  fontSize: 25,
                ),
              ),
            )),
        pw.Container(
            height: PdfPageFormat.a4.availableHeight * .9,
            width: PdfPageFormat.a4.availableWidth * .98,
            child: pw.Center(
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                  children: [
                    pw.Text(
                      selectedDisciplineAtom.value!.name,
                      style: const pw.TextStyle(
                        fontSize: 60,
                      ),
                    ),
                    pw.Text(
                      userAtom.value.name,
                      style: const pw.TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    pw.Text(
                      DateFormat('yyyy').format(DateTime.now()),
                      style: const pw.TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ]),
            )),
        pw.Container(
            height: PdfPageFormat.a4.availableHeight * .05,
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                children: [
                  pw.Text('Class Manager II - Developed by @sraschen'),
                  pw.Text(DateFormat('dd/MM/yyyy  kk:mm:ss')
                      .format(DateTime.now())),
                ])),
      ]);
}

List<pw.Widget> pdfPages() {
  List<Classes> classesList = getDisciplineClasses(
    discipline: selectedDisciplineAtom.value,
    allClasses: userClassesAtom.value,
  );
  List<pw.Widget> listWidget = [firstPage()];
  for (var disciplineClass in classesList) {
    listWidget.add(pdfPageInfo(disciplineClass));
  }
  return listWidget;
}

pw.Widget pdfPageInfo(Classes disciplineClass) {
  List<Student> classStudents = disciplineClass.student.toList();
  return pw.Column(children: [
    for (int i = 0; i < 3; i++)
      pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          height: PdfPageFormat.a4.availableHeight * .98,
          width: PdfPageFormat.a4.availableWidth * .98,
          child: pw.Padding(
              padding: const pw.EdgeInsets.all(10.0),
              child: pw.Column(children: [
                pw.Text('Class ${disciplineClass.name} - ${i + 1}º TRI',
                    style: const pw.TextStyle(fontSize: 15)),
                pw.Divider(),
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(width: 1),
                        ),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .4,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                    ]),
                pw.ListView.builder(
                  itemCount: classStudents.length,
                  itemBuilder: (context, index) {
                    return pw.Row(children: [
                      pw.Container(
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1),
                          ),
                          width: PdfPageFormat.a4.availableWidth * .4,
                          height: 15,
                          child: pw.Text(
                            '  ${index + 1}. ${classStudents[index].name}',
                            style: const pw.TextStyle(
                              fontSize: 8,
                            ),
                          )),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                      pw.Container(
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        alignment: pw.Alignment.center,
                        width: PdfPageFormat.a4.availableWidth * .09,
                        height: 15,
                      ),
                    ]);
                  },
                )
              ]))),
  ]);
}

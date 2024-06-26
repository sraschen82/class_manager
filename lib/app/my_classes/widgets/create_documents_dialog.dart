import 'package:class_manager_two/app/comum/my_colors.dart';
import 'package:class_manager_two/app/comum/pdf/pdf_activity_worksheet_preview.dart';
import 'package:class_manager_two/app/comum/pdf/pdf_class_report_preview.dart';
import 'package:class_manager_two/app/my_classes/atoms/class_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Future<void> createDocumentsDialog(
  BuildContext context,
) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 117, 12, 12),
          insetPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          title: const Center(child: Text('Document Generator')),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Card(
                  color: const Color.fromARGB(255, 2, 1, 8).withOpacity(.1),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (selectedDisciplineAtom.value != null) {
                                  pdfActivityWorkSheetPreView(
                                      context: context,
                                      discipline:
                                          selectedDisciplineAtom.value!);
                                }
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 58, 93, 207)),
                              ),
                              child: const SizedBox(
                                width: 150,
                                child: Center(
                                  child: Text(
                                    'Activity Worksheet',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                if (selectedDisciplineAtom.value != null) {
                                  pdfClassReportPreView(
                                      context: context,
                                      discipline:
                                          selectedDisciplineAtom.value!);
                                }
                              },
                              style: const ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 58, 93, 207)),
                              ),
                              child: const SizedBox(
                                width: 150,
                                child: Center(
                                  child: Text(
                                    'Grades Report',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              )),
                          // TextButton(
                          //     onPressed: () => Navigator.of(context).pop(),
                          //     child: const Text('Activity Worksheet')),
                          // TextButton(
                          //     onPressed: () {
                          //       if (selectedDisciplineAtom.value != null) {
                          //         pdfViewDIalog(
                          //             context: context,
                          //             discipline:
                          //                 selectedDisciplineAtom.value!);
                          //       }
                          //     },
                          //     child: const Text('Grades Report')),
                        ],
                      )),
                    ),
                  ))
            ],
          )),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
          ],
        );
      });
}

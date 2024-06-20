import 'dart:io';

import 'package:class_manager_two/app/comum/pdf/pdf_class.dart';
import 'package:class_manager_two/app/my_classes/models/discipline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:share_extend/share_extend.dart';

Future<void> pdfViewDIalog(
    {required BuildContext context, required Discipline discipline}) async {
  String pdfPath = '';
  Future<File> viewFile = PDF().createPDF(fileName: discipline.name);
  viewFile.then((value) => pdfPath = value.path);

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          title: const Center(child: Text('PDF VIEW')),
          content: SingleChildScrollView(
              child: Column(
            children: [
              Card(
                  // color: Colors.amber,
                  child: SizedBox(
                height: 386.1,
                width: 273,
                child: Center(
                  child: FutureBuilder(
                    future: PDF().createPDF(fileName: discipline.name),
                    builder: (context, snapshot) {
                      List<Widget> children;

                      if (snapshot.hasData) {
                        children = [
                          SizedBox(
                            height: 386.1,
                            width: 273,
                            child: PDFView(
                              filePath: pdfPath,
                              enableSwipe: true,
                              swipeHorizontal: true,
                              autoSpacing: false,
                              pageFling: false,
                              // onRender: (_pages) {
                              //   setState(() {
                              //     pages = _pages;
                              //     isReady = true;
                              //   });
                              // },
                              onError: (error) {
                                print(error.toString());
                              },
                              onPageError: (page, error) {
                                print('$page: ${error.toString()}');
                              },
                              // onViewCreated:
                              //     (PDFViewController pdfViewController) {
                              //   _controller.complete(pdfViewController);
                              // },
                              // onPageChanged: (int page, int total) {
                              //   print('page change: $page/$total');
                              // },
                            ),
                          ),
                        ];
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Failed to create PDF. \n \nError: ${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ];
                      } else {
                        children = const <Widget>[
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          ),
                        ];
                      }
                      return Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: children,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ))
            ],
          )),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel')),
            TextButton(
              onPressed: () async {
                ShareExtend.share(pdfPath, 'file');
                // await Future.delayed(const Duration(seconds: 2));
                Navigator.of(context).pop();
              },
              child: const Text('Share'),
            ),
          ],
        );
      });
}

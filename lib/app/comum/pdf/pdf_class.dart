import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDF {
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
        height: 150,
        child: pw.Center(
          child: pw.Text('Class Manager'),
        ));
  }

  pw.Widget _footer(pw.Context context) {
    return pw.Container(
        height: 150,
        child: pw.Center(
          child: pw.Text('Class Manager II - Developed by @sraschen'),
        ));
  }

  _buildContent(pw.Context context) {
    return [
      pw.Container(
          height: 150,
          child: pw.Center(
            child: pw.Text('PDF'),
          ))
    ];
  }
}

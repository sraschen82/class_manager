import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDF {
  final pdf = pw.Document();
  createPDF() {
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          ); // Center
        })); // Page
  }
}

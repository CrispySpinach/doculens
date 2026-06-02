import 'dart:io';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  const PdfService();

  Future<String> extractText(
    String pdfPath,
  ) async {
    try {
      final bytes =
          await File(pdfPath).readAsBytes();

      final document =
          PdfDocument(inputBytes: bytes);

      final text =
          PdfTextExtractor(document)
              .extractText();

      document.dispose();

      return text;
    } catch (e) {
      throw Exception(
        'Failed to extract PDF text: $e',
      );
    }
  }
}
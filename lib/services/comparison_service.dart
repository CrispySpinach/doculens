import '../models/document.dart';
import '../models/comparison_result.dart';

import 'ffi_service.dart';
import 'pdf_service.dart';

class ComparisonService {
  final PdfService _pdfService =
      const PdfService();

  final FfiService _ffiService =
      FfiService();

  Future<List<ComparisonResult>>
      compareDocuments({
    required Document reference,
    required List<Document> comparisons,
  }) async {
    final referenceText =
        await _pdfService.extractText(
      reference.path,
    );

    print(
      'Reference Length: ${referenceText.length}',
    );

    final results =
        <ComparisonResult>[];

    for (final document
        in comparisons) {
      final comparisonText =
          await _pdfService.extractText(
        document.path,
      );

      final similarity =
          _ffiService.compare(
        referenceText,
        comparisonText,
        3,
      );

      print(
        '${document.fileName} -> ${similarity.toStringAsFixed(2)}%',
      );

      results.add(
        ComparisonResult(
          fileName:
              document.fileName,
          similarity:
              similarity,
        ),
      );
    }

    results.sort(
      (a, b) =>
          b.similarity.compareTo(
        a.similarity,
      ),
    );

    return results;
  }
}
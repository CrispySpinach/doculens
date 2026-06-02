import 'package:file_picker/file_picker.dart';

import '../models/document.dart';

class FilePickerService {
  const FilePickerService();

  /// Pick exactly one PDF for the reference document
  Future<Document?> pickReferenceDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final file = result.files.first;

    if (file.path == null) {
      return null;
    }

    return Document(
      fileName: file.name,
      path: file.path!,
    );
  }

  /// Pick multiple PDFs for comparison
  Future<List<Document>> pickComparisonDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );

    if (result == null) {
      return [];
    }

    return result.files
        .where((file) => file.path != null)
        .map(
          (file) => Document(
            fileName: file.name,
            path: file.path!,
          ),
        )
        .toList();
  }
}
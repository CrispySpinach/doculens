import 'package:flutter/material.dart';

import '../models/comparison_result.dart';
import '../models/document.dart';

import '../services/comparison_service.dart';
import '../services/file_picker_service.dart';

import '../widgets/compare_button.dart';
import '../widgets/drop_zone.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {
  final FilePickerService
      _filePickerService =
      const FilePickerService();

  final ComparisonService
      _comparisonService =
      ComparisonService();

  Document? _referenceDocument;

  List<Document>
      _comparisonDocuments = [];

  List<ComparisonResult>
      _results = [];

  Future<void>
      _pickReferenceDocument() async {
    final document =
        await _filePickerService
            .pickReferenceDocument();

    if (document == null) {
      return;
    }

    setState(() {
      _referenceDocument = document;
    });
  }

  Future<void>
      _pickComparisonDocuments() async {
    final documents =
        await _filePickerService
            .pickComparisonDocuments();

    setState(() {
      _comparisonDocuments = documents;
    });
  }

  Future<void>
      _runComparison() async {
    if (_referenceDocument == null) {
      return;
    }

    if (_comparisonDocuments
        .isEmpty) {
      return;
    }

    final results =
        await _comparisonService
            .compareDocuments(
      reference:
          _referenceDocument!,
      comparisons:
          _comparisonDocuments,
    );

    setState(() {
      _results = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('DocuLens'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(24),
        child: Column(
          children: [
            DocumentDropZone(
              title: 'Reference Document',
              subtitle: _referenceDocument == null
                  ? 'Click or Drop PDF'
                  : _referenceDocument!.fileName,
              onTap: _pickReferenceDocument,
              onFilesDropped: (paths) {
                if (paths.isEmpty) {
                  return;
                }

                final path = paths.first;

                if (!path
                    .toLowerCase()
                    .endsWith('.pdf')) {
                  return;
                }

                final fileName =
                    path.split(r'\').last;

                setState(() {
                  _referenceDocument =
                      Document(
                    fileName: fileName,
                    path: path,
                  );
                });
              },
            ),

            const SizedBox(
                height: 24),

            DocumentDropZone(
              title: 'Comparison Documents',
              subtitle: _comparisonDocuments.isEmpty
                  ? 'Click or Drop PDFs'
                  : '${_comparisonDocuments.length} file(s) selected',
              onTap: _pickComparisonDocuments,
              onFilesDropped: (paths) {
                final documents =
                    paths
                        .where(
                          (path) => path
                              .toLowerCase()
                              .endsWith('.pdf'),
                        )
                        .map(
                          (path) => Document(
                            fileName:
                                path
                                    .split(
                                      r'\',
                                    )
                                    .last,
                            path: path,
                          ),
                        )
                        .toList();

                setState(() {
                  _comparisonDocuments =
                      documents;
                });
              },
            ),

            const SizedBox(
                height: 24),

            CompareButton(
              onPressed:
                  _runComparison,
            ),

            const SizedBox(
                height: 24),

            if (_results.isNotEmpty)
              Expanded(
                child: ListView
                    .builder(
                  itemCount:
                      _results.length,
                  itemBuilder:
                      (context,
                          index) {
                    final result =
                        _results[
                            index];

                    return ListTile(
                      leading:
                          const Icon(
                        Icons
                            .picture_as_pdf,
                      ),
                      title:
                          Text(
                        result
                            .fileName,
                      ),
                      trailing:
                          Text(
                        '${result.similarity.toStringAsFixed(2)}%',
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/documents/cubit/document_cubit.dart';
import 'package:nutri_app/app/documents/cubit/document_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerPage extends StatelessWidget {
  const PDFViewerPage({super.key});

  Future<String> _savePdfFile(String base64Data, String filename) async {
    final decodedBytes = base64Decode(base64Data);
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$filename';
    final file = File(filePath);
    await file.writeAsBytes(decodedBytes);
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentCubit, DocumentState>(
      builder: (context, state) {
        if (state is LoadingDocumentState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoadedDocumentState) {
          return FutureBuilder<String>(
            future: _savePdfFile(state.fileData, state.filename),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(child: Text('Erro ao carregar o PDF')),
                );
              } else {
                final filePath = snapshot.data!;
                return Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: () => context.go('/documents'),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    title: Text(
                      state.filename,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: const Color(0xFF83C5BE),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                  body: SfPdfViewer.file(
                    File(filePath),
                  ),
                );
              }
            },
          );
        } else if (state is ErrorDocumentState) {
          return Scaffold(
            body: Center(child: Text(state.message)),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('Selecione um documento.')),
          );
        }
      },
    );
  }
}

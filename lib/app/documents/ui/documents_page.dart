import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/documents/cubit/list_documents_cubit.dart';
import 'package:nutri_app/app/documents/cubit/list_documents_states.dart';
import 'package:nutri_app/app/documents/models/Document.dart';
import 'package:nutri_app/app/documents/ui/components/document_item.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  late final ListDocumentsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ListDocumentsCubit>(context);
    cubit.fetchDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text(
          'Impressos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF83C5BE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocBuilder(
          bloc: cubit,
          builder: (context, state) {
            if (state is LoadingListDocumentsState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedListDocumentsState) {
              return _buildDocumentsList(state.documents);
            } else if (state is ErrorListDocumentsState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Text("Erro desconhecido");
            }
          },
        ),
      ),
    );
  }

  Widget _buildDocumentsList(List<Document> documents) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (_, index) {
        final document = documents[index];

        return DocumentItem(document: document);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/app/documents/cubit/document_cubit.dart';
import 'package:nutri_app/app/documents/models/Document.dart';
import 'package:nutri_app/config/extension.dart';

class DocumentItem extends StatelessWidget {
  final Document document;

  const DocumentItem({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: InkWell(
          onTap: () async {
            context.read<DocumentCubit>().fetchDocumentById(document.id);
            context.go('/document/view');
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: const Icon(Icons.assignment),
              trailing: const Icon(Icons.arrow_forward),
              title: Text(
                document.filename,
                style: context.textTheme.titleMedium
                    ?.copyWith(color: context.colorScheme.onSurface),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

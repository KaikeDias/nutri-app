import 'package:nutri_app/app/documents/models/Document.dart';

abstract class ListDocumentsState {}

class InitialListDocumentsState extends ListDocumentsState {}

class LoadingListDocumentsState extends ListDocumentsState {}

class LoadedListDocumentsState extends ListDocumentsState {
  final List<Document> documents;

  LoadedListDocumentsState(this.documents);
}

class ErrorListDocumentsState extends ListDocumentsState {
  final String message;

  ErrorListDocumentsState(this.message);
}
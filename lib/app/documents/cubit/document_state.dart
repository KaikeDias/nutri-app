abstract class DocumentState {}

class InitialDocumentState extends DocumentState {}

class LoadingDocumentState extends DocumentState {}

class LoadedDocumentState extends DocumentState {
  final String fileData; 
  final String filename;

  LoadedDocumentState({required this.fileData, required this.filename});
}

class ErrorDocumentState extends DocumentState {
  final String message;

  ErrorDocumentState(this.message);
}
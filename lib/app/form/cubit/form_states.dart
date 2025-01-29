import 'package:nutri_app/app/form/models/question.dart';

abstract class AFormState {}

class InitialFormState extends AFormState{}

class LoadingFormState extends AFormState {}

class LoadedFormState extends AFormState {
  final List<Question> questions;

  LoadedFormState({required this.questions});
}

class SuccessFormState extends AFormState {}

class ErrorFormState extends AFormState {
  final String message;

  ErrorFormState(this.message);
}

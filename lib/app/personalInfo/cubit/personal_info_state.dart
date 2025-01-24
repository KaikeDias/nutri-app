import 'package:nutri_app/app/auth/models/patient.dart';

class PersonalInfoState {}

class InitialPersonalInfoState extends PersonalInfoState {}

class LoadingPersonalInfoState extends PersonalInfoState {}

class LoadedPersonalInfoState extends PersonalInfoState {
  final Patient patient;

  LoadedPersonalInfoState(this.patient);
}

class ErrorPersonalInfoState extends PersonalInfoState {
  final String message;

  ErrorPersonalInfoState(this.message);
}

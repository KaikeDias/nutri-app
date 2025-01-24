import 'package:nutri_app/app/guidelines/models/guideline.dart';

class GuidelineState {}

class InitialGuidelineState extends GuidelineState {}

class LoadingGuidelineState extends GuidelineState {}

class LoadedGuidelineState extends GuidelineState {
  final List<Guideline> guidelines;

  LoadedGuidelineState(this.guidelines);
}

class ErrorGuidelineState extends GuidelineState {
  final String message;

  ErrorGuidelineState(this.message);
}
import 'package:nutri_app/app/menu/models/food.dart';

abstract class SubstitutionsState {}

class InitialSubstitutionsState extends SubstitutionsState {}

class LoadingSubstitutionsState extends SubstitutionsState {}

class LoadedSubstitutionsState extends SubstitutionsState {
  final List<Food> aliments;

  LoadedSubstitutionsState(this.aliments);
}

class ErrorSubstitutionsState extends SubstitutionsState {
  final String message;

  ErrorSubstitutionsState(this.message);
}

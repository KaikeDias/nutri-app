import 'package:nutri_app/app/dietEntry/models/diet_entry_dto.dart';

abstract class DietEntryState {}

class InitialDietEntryState extends DietEntryState {}

class LoadingDietEntryState extends DietEntryState {}

class LoadedDietEntryState extends DietEntryState {
  final Map<String, List<DietEntryDto>> entries;

  LoadedDietEntryState(this.entries);
}

class ErrorDietEntryState extends DietEntryState {
  final String message;

  ErrorDietEntryState(this.message);
}
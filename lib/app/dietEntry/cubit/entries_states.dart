import 'package:nutri_app/app/dietEntry/models/diet_entry.dart';

abstract class EntryState {}

class InitialEntryState extends EntryState {}

class LoadingEntryState extends EntryState {} 

class LoadedEntryState extends EntryState {
  final DietEntry dietEntry;

  LoadedEntryState(this.dietEntry);
} 

class ErrorEntryState extends EntryState {
  final String message;

  ErrorEntryState(this.message);
} 
import 'package:nutri_app/app/menu/models/meal.dart';

abstract class MenuState {}

class InitialMenuState extends MenuState {}

class LoadingMenuState extends MenuState {}

class LoadedMenuState extends MenuState {
  final List<Meal> meals;

  LoadedMenuState(this.meals);
}

class ErrorMenuState extends MenuState {
  final String message;

  ErrorMenuState(this.message);
}
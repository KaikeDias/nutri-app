import 'package:nutri_app/app/menu/models/food.dart';

class Meal {
  final String id;
  final String title;
  final String mealTime;
  final List<Food> aliments;

  Meal({required this.id, required this.title, required this.mealTime, required this.aliments});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json["id"],
      title: json["title"],
      mealTime: json["mealTime"].toString(),
      aliments: (json['aliments'] as List)
      .map((food) => Food.fromJson(food))
      .toList(),
    );
  } 
}
import 'package:flutter/material.dart';
import 'package:nutri_app/app/menu/ui/components/register_meal.dart';
import 'package:nutri_app/config/extension.dart';

import 'meal_item.dart';

class MealCard extends StatelessWidget {
  final String mealName;
  final String mealTime;
  final List<MealItem> items;

  const MealCard(
      {super.key,
      required this.mealName,
      required this.items,
      required this.mealTime});

  String convertMealTime(String mealTime) {
    return mealTime.substring(0, 5);
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RegisterMealDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(
        children: [
          Text(
            mealName,
            style: context.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            convertMealTime(mealTime),
            style: context.textTheme.titleSmall?.copyWith(color: Colors.grey),
          ),
          const Divider(),
          Column(
            children: items,
          ),
          const SizedBox(height: 8),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                _showPopup(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(context.colorScheme.primary),
              ),
              child: Text(
                '+ Registrar',
                style: context.textTheme.labelLarge
                    ?.copyWith(color: context.colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'meal_item.dart';

class MealCard extends StatelessWidget {
  final String mealName;
  final List<MealItem> items;

  const MealCard({super.key, required this.mealName, required this.items});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Column(
            children: items,
          ),
          const SizedBox(height: 8),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(colorScheme.primary),
              ),
              child: Text(
                '+ Registrar',
                style: textTheme.labelLarge
                    ?.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'meal_item.dart';

class MealCard extends StatelessWidget {
  final String mealName;
  final List<MealItem> items;

  const MealCard({super.key, required this.mealName, required this.items});

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
          const Text(
            'Refeicao X',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(),
          Column(
            children: items,
          ),
          const SizedBox(height: 8),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Registrar',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

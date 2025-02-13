import 'package:flutter/material.dart';
import 'package:nutri_app/app/menu/ui/components/substitutions_dialog.dart';
import 'package:nutri_app/config/extension.dart';

import '../../models/food.dart';

class MealItem extends StatelessWidget {
  final Food food;

  const MealItem({super.key, required this.food});

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SubstitutionsDialog(food: food);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            food.name,
            style: context.textTheme.titleMedium,
          ),
          subtitle: Text(
            '${food.homeQuantity} ${food.homeUnit} (${food.quantity}${food.unit})',
            style: context.textTheme.labelLarge
                ?.copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
          trailing: OutlinedButton(
            onPressed: () => _showPopup(context),
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(10)),
            child: Text(
              'Substituições',
              style: context.textTheme.labelLarge
                  ?.copyWith(color: context.colorScheme.primary),
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}

import 'package:flutter/material.dart';

class MealItem extends StatelessWidget {
  final String title;
  final String quantity;

  const MealItem({super.key, required this.title, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: textTheme.titleMedium,
          ),
          subtitle: Text(
            quantity,
            style: textTheme.labelLarge
                ?.copyWith(color: colorScheme.onSurfaceVariant),
          ),
          trailing: OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: colorScheme.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.all(10)),
            child: Text(
              'Substituições',
              style: textTheme.labelLarge?.copyWith(color: colorScheme.primary),
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}

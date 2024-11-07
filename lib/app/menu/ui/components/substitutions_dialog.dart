import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutri_app/app/menu/models/food.dart';

class SubstitutionsDialog extends StatefulWidget {
  final Food food;

  const SubstitutionsDialog({super.key, required this.food});

  @override
  State<SubstitutionsDialog> createState() => _SubstitutionsDialogState();
}

class _SubstitutionsDialogState extends State<SubstitutionsDialog> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final List<Food> substitutions = widget.food.substituitions;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Substituições",
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: substitutions.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 2, bottom: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colorScheme.onSurface,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: colorScheme.secondaryContainer,
                  ),
                  child: ListTile(
                    title: Text(
                      substitutions[index].name,
                      style: textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      substitutions[index].quantity,
                      style: textTheme.labelLarge
                          ?.copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Fechar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

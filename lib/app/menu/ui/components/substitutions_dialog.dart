import 'package:flutter/material.dart';
import 'package:nutri_app/app/menu/models/food.dart';
import 'package:nutri_app/config/extension.dart';

class SubstitutionsDialog extends StatefulWidget {
  final Food food;

  const SubstitutionsDialog({super.key, required this.food});

  @override
  State<SubstitutionsDialog> createState() => _SubstitutionsDialogState();
}

class _SubstitutionsDialogState extends State<SubstitutionsDialog> {
  @override
  Widget build(BuildContext context) {
    final List<Food> substitutions = widget.food.substituitions;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: const Color(0xFFDEE4E4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Substituições",
              style: context.textTheme.titleLarge?.copyWith(
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
                  margin: const EdgeInsets.only(top: 2, bottom: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white
                  ),
                  child: ListTile(
                    title: Text(
                      substitutions[index].name,
                      style: context.textTheme.titleMedium?.copyWith(color: context.colorScheme.primary),
                    ),
                    subtitle: Text(
                      substitutions[index].quantity,
                      style: context.textTheme.labelLarge
                          ?.copyWith(color: context.colorScheme.onSurfaceVariant),
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

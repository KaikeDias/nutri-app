import 'package:flutter/material.dart';
import 'package:nutri_app/app/guidelines/models/guideline.dart';
import 'package:nutri_app/config/extension.dart';

class GuidelineDialog extends StatefulWidget {
  final Guideline guideline;

  const GuidelineDialog({super.key, required this.guideline});

  @override
  State<GuidelineDialog> createState() => _GuidelineDialogState();
}

class _GuidelineDialogState extends State<GuidelineDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.guideline.title,
                style: context.textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const Divider(),
              Text(
                widget.guideline.content,
                style: context.textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nutri_app/app/guidelines/models/guideline.dart';
import 'package:nutri_app/app/guidelines/ui/components/guideline_dialog.dart';
import 'package:nutri_app/config/extension.dart';

class GuidelineItem extends StatelessWidget {
  final Guideline guideline;

  const GuidelineItem({super.key, required this.guideline});

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GuidelineDialog(guideline: guideline);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: InkWell(
          onTap: () => _showPopup(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: const Icon(Icons.assignment),
              title: Text(
                guideline.title,
                style: context.textTheme.titleMedium
                    ?.copyWith(color: context.colorScheme.onSurface),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

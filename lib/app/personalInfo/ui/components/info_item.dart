import 'package:flutter/material.dart';
import 'package:nutri_app/config/extension.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const InfoItem({super.key, required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(
            title,
            style: context.textTheme.titleMedium,
          ),
          subtitle: Text(
            subtitle,
            style: context.textTheme.bodyLarge,
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

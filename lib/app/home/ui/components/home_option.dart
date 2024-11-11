import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutri_app/config/extension.dart';

class HomeOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const HomeOption(
      {super.key,
      required this.title,
      required this.icon,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Ink(
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
        onTap: () {
          context.go(route);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            title: Text(
              title,
              style: context.textTheme.titleMedium
                  ?.copyWith(color: context.colorScheme.onSurface),
            ),
            leading: Icon(icon),
          ),
        ),
      ),
    );
  }
}

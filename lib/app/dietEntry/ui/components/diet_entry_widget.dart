import 'package:flutter/material.dart';
import 'package:nutri_app/app/dietEntry/ui/entries_page.dart';
import 'package:nutri_app/config/extension.dart';

class EntriesList extends StatelessWidget {
  final Map<String, List> entries;

  const EntriesList({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: entries.keys.map((date) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
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
              onTap: () {
                // Redirecionar para outra página com os registros daquela data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EntriesPage(date: date, entries: entries[date]!),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(
                  leading: const Icon(Icons.event),
                  title: Text(
                    "12/02/2025", // Exibindo apenas a data
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

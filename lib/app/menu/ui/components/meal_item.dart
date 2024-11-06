import 'package:flutter/material.dart';

class MealItem extends StatelessWidget {
  final String title;
  final String quantity;

  const MealItem({super.key, required this.title, required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(quantity)
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFF83C5BE)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          child: const Text(
            'Opções de Substituição',
            style: TextStyle(color: Color(0xFF83C5BE)),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

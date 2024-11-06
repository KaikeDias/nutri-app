import 'package:flutter/material.dart';
import 'package:nutri_app/app/menu/ui/components/meal_card.dart';
import 'package:nutri_app/app/menu/ui/components/meal_item.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            MealCard(
              mealName: 'Refeição 1',
              items: [
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
              ],
            ),
            MealCard(
              mealName: 'Refeição 1',
              items: [
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
              ],
            ),
            MealCard(
              mealName: 'Refeição 1',
              items: [
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
              ],
            ),
            MealCard(
              mealName: 'Refeição 1',
              items: [
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
              ],
            ),
            MealCard(
              mealName: 'Refeição 1',
              items: [
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
                MealItem(title: 'Ovo', quantity: '2 unidade(s) média(s)'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

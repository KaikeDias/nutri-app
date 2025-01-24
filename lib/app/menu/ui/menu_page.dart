import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_app/app/menu/cubits/menu_cubit.dart';
import 'package:nutri_app/app/menu/cubits/menu_states.dart';
import 'package:nutri_app/app/menu/models/meal.dart';
import 'package:nutri_app/app/menu/ui/components/meal_card.dart';
import 'package:nutri_app/app/menu/ui/components/meal_item.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late final MenuCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<MenuCubit>(context);
    cubit.fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder(
            bloc: cubit,
            builder: (context, state) {
              if (state is LoadingMenuState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedMenuState) {
                final meals = state.meals;

                return _buildMealsList(meals);
              } else if (state is ErrorMenuState) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                return const Text("Erro desconhecido");
              }
            },
          )),
    );
  }

  Widget _buildMealsList(List<Meal> meals) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (_, index) {
        final Meal meal = meals[index];
        return MealCard(
          mealName: meal.title,
          items: meal.aliments.map((food) {
            return MealItem(food: food);
          }).toList(),
        );
      },
    );
  }
}

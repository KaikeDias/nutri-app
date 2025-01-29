import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_app/app/goals/cubit/water_goal_cubit.dart';
import 'package:nutri_app/config/extension.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterGoalPage extends StatefulWidget {
  const WaterGoalPage({super.key});

  @override
  State<WaterGoalPage> createState() => _WaterGoalPageState();
}

class _WaterGoalPageState extends State<WaterGoalPage> {
  int currentWater = 0;

  @override
  void initState() {
    super.initState();
    _loadWaterData();
    // Carrega o estado inicial do Cubit
    context.read<WaterGoalCubit>().loadWaterGoal();
  }

  // Carrega a quantidade de água atual do SharedPreferences
  void _loadWaterData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentWater = prefs.getInt('currentWater') ?? 0;
    });
  }

  // Salva a quantidade de água no SharedPreferences
  void _saveWaterData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentWater', currentWater);
  }

  // Função para adicionar água
  void addWater(int amount) {
    setState(() {
      final cubit = context.read<WaterGoalCubit>();
      currentWater = (currentWater + amount).clamp(0, cubit.state);
      _saveWaterData(); // Salva a quantidade após cada adição
    });
  }

  // Função para resetar a quantidade de água
  void resetWater() {
    setState(() {
      currentWater = 0;
      _saveWaterData(); // Salva o valor 0 após o reset
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterGoalCubit, int>(
      builder: (context, waterGoal) {
        double progress = currentWater / waterGoal;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 15.0,
                percent: progress > 1 ? 1 : progress,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '$currentWater/$waterGoal ml',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                progressColor: Colors.blue,
                backgroundColor: Colors.blue.shade100,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => addWater(200),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('+ 200ml',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetWater,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Resetar',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }
}

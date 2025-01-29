import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_app/app/auth/models/patient.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterGoalCubit extends Cubit<int> {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;

  WaterGoalCubit() : super(0);

  Future<void> loadWaterGoal() async {
    final prefs = await SharedPreferences.getInstance();

    final savedGoal = prefs.getInt("waterGoal");
    if (savedGoal != null) {
      emit(savedGoal);
    } else {
      final fetchedGoal = await fetchWaterGoal();
      emit(fetchedGoal);

      prefs.setInt("waterGoal", fetchedGoal);
    }
  }

  Future<int> fetchWaterGoal() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      final String? data = prefs.getString('patient');

      if (token == null) {
        throw Exception("Token nao encontrado");
      }

      if (data == null) {
        throw Exception("Paciente não encontrado");
      }

      final Map<String, dynamic> rawJson = jsonDecode(data);
      print("$baseUrl/waterGoals/${rawJson["waterGoalID"]}");

      final response = await _dio.get(
        "$baseUrl/waterGoals/${rawJson["waterGoalID"]}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Passando o token
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Erro ao buscar Orientaçoes nutricionais: ${response.statusCode}');
      } else {
        return response.data['goal'];
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }
}

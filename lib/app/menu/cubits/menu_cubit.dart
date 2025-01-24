import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_app/app/menu/cubits/menu_states.dart';
import 'package:nutri_app/app/menu/models/meal.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuCubit extends Cubit<MenuState> {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;
  final List<Meal> meals = [];

  MenuCubit() : super(InitialMenuState());

  Future<void> fetchMeals() async {
    emit(LoadingMenuState());

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString('auth_token');
      final String? patientJson = prefs.getString('patient');

      if (authToken == null) {
        throw Exception("Token de autenticação não encontrado");
      }

      if (patientJson == null) {
        throw Exception("Informações do paciente não encontradas");
      }

      final Map<String, dynamic> rawJson = await jsonDecode(patientJson);
      final response = await _dio.get(
        '$baseUrl/menus/${rawJson['menuID']}/meals',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken', // Passando o token
          },
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        meals.clear();
        meals.addAll(data.map((meal) => Meal.fromJson(meal)).toList());

        emit(LoadedMenuState(meals));
      } else {
        emit(
            ErrorMenuState("Erro ao buscar refeições: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ErrorMenuState("Erro: ${e.toString()}"));
    }
  }
}

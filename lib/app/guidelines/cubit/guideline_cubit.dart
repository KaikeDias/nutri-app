import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_app/app/guidelines/cubit/guideline_states.dart';
import 'package:nutri_app/app/guidelines/models/guideline.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuidelineCubit extends Cubit<GuidelineState> {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;
  final List<Guideline> guidelines = [];

  GuidelineCubit() : super(InitialGuidelineState());

  Future<void> fetchGuidelines() async {
    emit(LoadingGuidelineState());

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      final String? data = prefs.getString('patient');

      if (token == null) {
        throw Exception("Token nao encontrado");
      }

      if (data == null) {
        throw Exception('Paciente nao encontrado');
      }

      final Map<String, dynamic> rawJson = jsonDecode(data);

      final response = await _dio.get(
        '$baseUrl/guidelines/patients/${rawJson['id']}',
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
        final List<dynamic> responseData = response.data;

        guidelines.clear();
        guidelines.addAll(responseData
            .map((guideline) => Guideline.fromJson(guideline))
            .toList());

        emit(LoadedGuidelineState(guidelines));
      }
    } catch (e) {
      emit(ErrorGuidelineState(
          "Erro ao buscar Orientaçoes nutricionais: ${e.toString()}"));
    }
  }
}

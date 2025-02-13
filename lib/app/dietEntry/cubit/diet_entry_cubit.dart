import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:nutri_app/app/dietEntry/cubit/diet_entry_states.dart';
import 'package:nutri_app/app/dietEntry/models/diet_entry_dto.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietEntryCubit extends Cubit {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;

  DietEntryCubit() : super(InitialDietEntryState());

  Future<void> fetchEntries() async {
    emit(LoadingDietEntryState());

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
        '$baseUrl/dietEntries/patients/${rawJson["id"]}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final Map<String, List<DietEntryDto>> entries = data.map(
          (date, entries) {
            final entryList = (entries as List)
                .map((entry) => DietEntryDto(
                      id: entry['id'],
                      title: entry['title'],
                    ))
                .toList();

            return MapEntry(date, entryList);
          },
        );

        emit(LoadedDietEntryState(entries));
      }else {
        emit(ErrorDietEntryState(
            "Erro ao carregar os registros: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ErrorDietEntryState(e.toString()));
    }
  }
}

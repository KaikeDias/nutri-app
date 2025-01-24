import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:nutri_app/app/auth/models/patient.dart';
import 'package:nutri_app/app/personalInfo/cubit/personal_info_state.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;

  PersonalInfoCubit() : super(InitialPersonalInfoState());

  Future<void> fetchPersonalInfo() async {
    emit(LoadingPersonalInfoState());

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');
      final String? patientData = prefs.getString('patient');

      if (token == null) {
        throw Exception("Token nao encontrado");
      }

      if (patientData == null) {
        throw Exception('Paciente nao encontrado');
      }

      final Map<String, dynamic> rawJson = jsonDecode(patientData);
      final Patient patient = Patient.fromJson(rawJson);

      emit(LoadedPersonalInfoState(patient));
    } catch (e) {
      emit(ErrorPersonalInfoState('Erro ao buscar informações pessoais: ${e}'));
    }
  }
}

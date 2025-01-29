import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:nutri_app/app/form/cubit/form_states.dart';
import 'package:nutri_app/app/form/models/question.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormCubit extends Cubit<AFormState> {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;
  final List<Question> questions = [];

  FormCubit() : super(InitialFormState());

  Future<void> fetchQuestions() async {
    emit(LoadingFormState());

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
        "$baseUrl/forms/patients/${rawJson["id"]}",
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> questionsData = response.data;

        List<Question> questionList = questionsData.map((item) {
          return Question.fromJson(item);
        }).toList();

        questions.clear();
        questions.addAll(questionList);

        emit(LoadedFormState(questions: questions));
      } else {
        emit(ErrorFormState(
            "Erro ao carregar as perguntas: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ErrorFormState(e.toString()));
    }
  }

  Future<void> saveAnswers() async {
    emit(LoadingFormState());

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString('auth_token');

      if (authToken == null) {
        throw Exception("Token de autenticação não encontrado");
      }

      final body = questions
          .map((question) =>
              {"questionId": question.id, "answer": question.answer})
          .toList();

      final response = await _dio.put(
        "$baseUrl/forms/questions/answers",
        data: body,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        emit(SuccessFormState());
        fetchQuestions();
      } else {
        emit(ErrorFormState(
            "Erro ao carregar as perguntas: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ErrorFormState(e.toString()));
    }
  }
}

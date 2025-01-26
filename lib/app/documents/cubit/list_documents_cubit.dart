import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:nutri_app/app/documents/cubit/list_documents_states.dart';
import 'package:nutri_app/app/documents/models/Document.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListDocumentsCubit extends Cubit<ListDocumentsState> {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;
  final List<Document> documents = [];

  ListDocumentsCubit() : super(InitialListDocumentsState());

  Future<void> fetchDocuments() async {
    emit(LoadingListDocumentsState());

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
        '$baseUrl/documents/patients/${rawJson["id"]}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Passando o token
          },
        ),
      );

      if(response.statusCode != 200) {
        throw Exception(
            'Erro ao buscar documentos: ${response.statusCode}');
      } else {
        final List<dynamic> responseData = response.data;

        documents.clear();
        documents.addAll(responseData.map((document) => Document.fromJson(document)).toList());

        emit(LoadedListDocumentsState(documents));
      }
    } catch (e) {
      emit(
          ErrorListDocumentsState("Erro ao buscar documentos ${e.toString()}"));
    }
  }
}

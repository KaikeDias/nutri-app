import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:nutri_app/app/documents/cubit/document_state.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentCubit extends Cubit<DocumentState> {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;

  DocumentCubit() : super(InitialDocumentState());

  Future<void> fetchDocumentById(String id) async {
    emit(LoadingDocumentState());

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("Token não encontrado");
      }

      final response = await _dio.get(
        '$baseUrl/documents/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Passando o token
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Erro ao buscar documento: ${response.statusCode}');
      } else {
        // `response.data` já é um Map<String, dynamic>, não é necessário usar jsonDecode.
        final data = response.data;

        emit(LoadedDocumentState(
          fileData: data['fileData'],
          filename: data['filename'],
        ));
      }
    } catch (e) {
      emit(ErrorDocumentState("Erro ao buscar documento: ${e.toString()}"));
    }
  }
}

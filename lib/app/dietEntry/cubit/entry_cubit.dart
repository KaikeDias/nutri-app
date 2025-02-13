import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutri_app/app/dietEntry/cubit/entries_states.dart';
import 'package:nutri_app/app/dietEntry/models/diet_entry.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryCubit extends Cubit<EntryState> {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;

  EntryCubit() : super(InitialEntryState());

  Future<DietEntry?> fetchEntry(String entryId) async {
    emit(LoadingEntryState());

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? authToken = prefs.getString('auth_token');

      if (authToken == null) {
        throw Exception("Token de autenticação não encontrado");
      }

      final response = await _dio.get(
        "$baseUrl/dietEntries/$entryId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if(response.statusCode == 200) {
        DietEntry entry = DietEntry.fromJson(response.data);

        emit(LoadedEntryState(entry));
        return entry;
      } else {
        emit(ErrorEntryState("Erro ao buscar registor: ${response.statusCode}"));
        throw Exception("Erro ao buscar registor: ${response.statusCode}");
      }
    } catch (e) {
      emit(ErrorEntryState(e.toString()));
    }
  }
}

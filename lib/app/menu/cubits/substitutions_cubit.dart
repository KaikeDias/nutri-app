import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:nutri_app/app/menu/cubits/substitutions_states.dart';
import 'package:nutri_app/app/menu/models/food.dart';
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubstitutionsCubit extends Cubit<SubstitutionsState> {
  final Dio _dio = Dio();
  final String baseUrl = ApiConfig.baseUrl;

  SubstitutionsCubit() : super(InitialSubstitutionsState());

  Future<void> fetchSubstitutions(String foodId) async {
    emit(LoadingSubstitutionsState());

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token');

      if (token == null) {
        throw Exception("Token nao encontrado");
      }

      final response = await _dio.get(
        '$baseUrl/menus/meals/$foodId/substitutions',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Passando o token
          },
        ),
      );

      if (response.statusCode != 200) {
        emit(ErrorSubstitutionsState("Erro ao buscar substituições: ${response.statusCode}"));
      } else {
        final List<dynamic> data = response.data;

        final List<Food> aliments =
            data.map((food) => Food.fromJson(food)).toList();

        emit(LoadedSubstitutionsState(aliments));
      }
    } catch (e) {
      emit(ErrorSubstitutionsState("Erro: ${e.toString()}"));
    }
  }
}

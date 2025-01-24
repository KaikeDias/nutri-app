import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final bool isAuthenticated;

  AuthState(this.isAuthenticated);
}

class AuthCubit extends Cubit<AuthState>{
  AuthCubit(): super(AuthState(false));

  Future<void> checkAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if(token != null && token.isNotEmpty) {
      emit(AuthState(true));
    } else {
      emit(AuthState(false));
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    emit(AuthState(false));
  }
}
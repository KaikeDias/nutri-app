import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:nutri_app/config/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final SharedPreferences prefs;
  final String baseUrl = ApiConfig.baseUrl;

  AuthController(this.prefs);

  Future<void> login(
      String username, String password, BuildContext context) async {
    final url = Uri.parse('$baseUrl/auth/patients/login');

    final body = jsonEncode({
      'username': username,
      'password': password,
    });

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final patient = data['patientDTO'];

        await prefs.setString('auth_token', token);
        await prefs.setString('patient', jsonEncode(patient));

        if (context.mounted) {
          context.go('/home');
        }
      } else {
        print('Login Falhou');
      }
    } catch (e) {
      print(e);
    }
  }
}

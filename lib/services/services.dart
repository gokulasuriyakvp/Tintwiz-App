/*
// lib/api/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/register_response.dart';
import 'config.dart';

class ApiService {
  Future<register_model?> registerUser(String name, String email, String password) async {
    String url = ApiUrl.url + ApiUrl.register;
    final data = jsonEncode({'name': name,
      'email': email,
      'password': password});
    try {
      final response = await http.post(
        Uri.parse('${ApiUrl.url}${ApiUrl.register}'),
        headers: {'Content-Type': 'application/json'},
        body: data
      );
      print('---- uRL ----- ${url}');


      if (response.statusCode == 200) {
        // Parse the JSON response into the register_model
        final jsonResponse = json.decode(response.body);

        print("------------Response:${response.body}");


        return register_model.fromJson(jsonResponse);
      } else {
        // Handle non-200 responses (e.g., display an error)
        print('Failed to register: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error occurred during registration: $e');
      return null;
    }
  }
}
*/

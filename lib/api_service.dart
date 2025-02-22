import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static late String apiUrl;

  static Future<void> loadConfig() async {
    final String configString = await rootBundle.loadString('assets/config.json');
    final Map<String, dynamic> config = json.decode(configString);
    apiUrl = config['API_URL'];
  }

  static Future<http.Response> registerUser(String email, String password) async {
  print('URL de l\'API: $apiUrl'); // Log pour vérifier l'URL de l'API
  print('Données envoyées: { "email": "$email", "password": "$password" }'); // Log des données envoyées

  final response = await http.post(
    Uri.parse('$apiUrl/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  print('Code de statut de la réponse: ${response.statusCode}'); // Log du code de statut de la réponse
  print('Corps de la réponse: ${response.body}'); // Log du corps de la réponse

  return response;
}

}

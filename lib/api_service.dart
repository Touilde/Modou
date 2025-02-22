import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

  return response;
}
static Future<String?> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('$apiUrl/users/sign-in'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Si la connexion est réussie, on retourne le token JWT
    return response.body; // Le corps de la réponse contient le token
  } else {
    // Si la connexion échoue, on renvoie null ou une valeur indiquant une erreur
    return null;
  }
}
}
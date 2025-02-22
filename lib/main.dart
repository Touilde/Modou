import 'package:flutter/material.dart';
import 'package:modou/api_service.dart';
import 'sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.loadConfig(); 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(), // Définir SignUpPage comme la page d'accueil
    );
  }
}
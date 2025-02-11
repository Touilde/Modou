import 'package:flutter/material.dart';
import 'sign_up.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SignUpPage(), // Définir SignUpPage comme la page d'accueil
    );
  }
}
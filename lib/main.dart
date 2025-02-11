// filepath: /Users/mathildeval/Documents/Master2/ArchitectureWebMobile/Leroux/Modou/lib/main.dart
import 'package:flutter/material.dart';
import 'package:modou/sign_up.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignUpPage(), // Définir SignUpPage comme la page d'accueil
    );
  }
}
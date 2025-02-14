import 'package:flutter/material.dart';
import 'package:modou/parameters_page.dart';
import 'sign_up.dart';
import 'login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modou',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUp(),
        '/login': (context) => const LoginPage(),
        '/parameters': (context) => const ParametersPage(),
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:modou/api_service.dart';
import 'package:modou/home.dart';
import 'package:modou/login.dart';
import 'package:modou/parameters.dart';
import 'sign_up.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ApiService.loadConfig(); 
  final storage = FlutterSecureStorage();
  String? token = await storage.read(key: 'auth_token');

  runApp(MainApp(isLoggedIn: token != null));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isLoggedIn ? HomePage() : SignUpPage(),
    );
  }
}
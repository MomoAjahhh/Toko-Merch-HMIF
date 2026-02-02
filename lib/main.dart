import 'package:flutter/material.dart';
import 'package:toko_merch_hmif/controller/userController.dart';
import 'package:toko_merch_hmif/models/user.dart';
import 'package:toko_merch_hmif/view/login.dart';
void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
    home: session(),
    );
    }
    Widget session() {
      UserController userController = UserController();
      WidgetsFlutterBinding.ensureInitialized();
        userController.checkSession().then((isLoggingin) {
          if (isLoggingin) {
          } else {
            runApp(const MainApp());
          }
        });
        return const LoginScreen();
  }
}
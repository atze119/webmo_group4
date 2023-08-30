import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webmo_group4/shared/constants.dart';
import 'package:webmo_group4/viewmodels/auth/auth_service.dart';
import 'package:webmo_group4/views/welcome/welcome_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: colorbg2,
    ));
    AuthService().signOut();
    return const MaterialApp(
      home: WelcomeView(),
    );
  }
}

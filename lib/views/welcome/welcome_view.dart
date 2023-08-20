import 'package:flutter/material.dart';
import 'package:webmo_group4/viewmodels/auth/authenticate.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return isPressed
        ? const Authenticate()
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Willkommen zur Essensplanung!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isPressed = true;
                      });
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'auth/auth_service.dart';
import 'auth/authenticate.dart';

class WillkommenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Willkommen zur Essensplanung!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Authenticate()), // Zeige den Authentifizierungsbildschirm
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

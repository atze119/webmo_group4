import 'package:flutter/material.dart';
import 'package:webmo_group4/shared/constants.dart';

import '../../../viewmodels/auth/auth_service.dart';

class HomeUser extends StatelessWidget {
  HomeUser({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorbg1,
      appBar: AppBar(
        backgroundColor: colorbg2,
        title: const Text("User Home Screen"),
        elevation: 0,
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorbg2,
              elevation: 0,
            ),
            icon: const Icon(Icons.person),
            label: const Text("logout"),
            onPressed: () async{
              await _authService.signOut();
            },
          ),
        ],
      ),
    );
  }
}

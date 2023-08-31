import 'package:flutter/material.dart';
import 'package:webmo_group4/shared/constants.dart';
import 'package:webmo_group4/views/food/food_view.dart';
import '../../../viewmodels/auth/auth_service.dart';
import '../foodplan/food_plan.dart';

class HomeAdmin extends StatelessWidget {
  HomeAdmin({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorbg1,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: colorbg2,
          title: const Text("Admin Ansicht"),
          actions: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: colorbg2,
                elevation: 0,
              ),
              icon: const Icon(Icons.person),
              label: const Text("ausloggen"),
              onPressed: () async {
                await _authService.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const FoodPlan()));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FoodView()));
              },
              child: const Text("Gehe zur Essensanzeige"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FoodPlan()));
              },
              child: const Text("Gehe zum Essensplan"),
            ),
          ],
        ));
  }
}

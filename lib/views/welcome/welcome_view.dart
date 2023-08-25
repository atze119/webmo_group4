import 'package:flutter/material.dart';
import 'package:webmo_group4/views/foodplan/food_plan.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FoodPlan(),
                ));
              },
              child: const Text('Essensplan'),
            ),
          ],
        ),
      ),
    );
  }
}
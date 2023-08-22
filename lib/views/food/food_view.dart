import 'package:flutter/material.dart';

import '../../viewmodels/food/food_service.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  late FoodService _foodService;

  @override
  void initState() {
    _foodService = FoodService();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Essen"),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () async {
                  await _foodService.createFood(context);
                },
                child: const Text("Essen anlegen")),
            TextButton(
                onPressed: () async {
                  await _foodService.updateFood(context);
                },
                child: const Text("Essen aktualisieren")),
            TextButton(
                onPressed: () async {
                  await _foodService.showFood(context);
                },
                child: const Text("Essen anzeigen")),
            TextButton(
                onPressed: () async {
                  await _foodService.deleteFood(context);
                },
                child: const Text("Essen löschen")),
          ],
        ),
      );
}

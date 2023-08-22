import 'package:flutter/material.dart';
import 'package:webmo_group4/models/repo/database_food.dart';
import 'package:webmo_group4/viewmodels/food/food_dialogs.dart';

import '../../models/foodmodel/food_model.dart';
import '../../viewmodels/food/food_service.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  // late TextEditingController controller;
  // late List<TextEditingController> listController;
  // FoodModel? foodModel;
  late FoodService _foodService;

  @override
  void initState() {
    // listController = [];
    // for (var i = 0; i <= 2; i++) {
    //   listController.add(TextEditingController());
    // }
    // controller = TextEditingController();
    // super.initState();
    _foodService = FoodService();
  }

  @override
  void dispose() {
    // for (var i = 0; i <= 2; i++) {
    //   listController[i].dispose();
    // }
    // controller.dispose();
    // super.dispose();
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

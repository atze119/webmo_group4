import 'package:flutter/material.dart';
import 'package:webmo_group4/models/foodmodel/food_model.dart';
import 'package:webmo_group4/models/repo/database_foodplan.dart';

import '../../viewmodels/food/food_service.dart';
import '../../viewmodels/foodplan/foodplan_service.dart';

class FoodPlanDialogs {
  late TextEditingController controller;
  static late List<TextEditingController>
  listController; // im not 100% about this static variable
  final FoodPlanService _foodPlanService = FoodPlanService();
  final FoodService _foodService = FoodService();

  FoodPlanDialogs() {
    listController = [];
    for (var i = 0; i <= 2; i++) {
      listController.add(TextEditingController());
    }
    controller = TextEditingController();
  }

  Future<List<TextEditingController>?> openCreateDialog({
    required BuildContext context, required String week, required String day
  }) =>
      showDialog<List<TextEditingController>>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Essen anlegen"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
                autofocus: true,
                decoration:
                const InputDecoration(hintText: "Geben Sie den Namen an"),
                controller: listController[0]), // == foodName
            TextField(
                decoration:
                const InputDecoration(hintText: "Geben Sie die Art an"),
                controller: listController[1]), // == foodType
            TextField(
                decoration:
                const InputDecoration(hintText: "Geben Sie den Preis an"),
                controller: listController[2]), // == price
          ]),
          actions: [
            TextButton(
              onPressed: () async {
                  await _foodPlanService.createFood(listController, week, day);
                  await _foodService.createFood(listController);
                Navigator.of(context).pop(listController);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "${FoodPlanService.foodModel?.name} wurde zur Datenbank hinzugefügt")));
              },
              child: const Text("HINZUFÜGEN"),
            )
          ],
        ),
      );

  Future<void> showFood({
    required BuildContext context, required String day, required int week})
  => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: FutureBuilder<FoodModel?>(
              future: _foodPlanService.getFoodDetails(week, day),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Fehler: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('Keine Daten verfügbar');
                } else {
                  FoodModel foodDetails = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Name: ${foodDetails.name}"),
                      Text("Art: ${foodDetails.foodType}"),
                      Text("Preis: ${foodDetails.price}"),
                    ],
                  );
                }
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("SCHLIEßEN"))
            ],
          );
        }
    );
}
import 'package:flutter/material.dart';

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

  // void showFood(
  //     {required BuildContext context}) =>
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text("Name: ${foodModel?.name}"),
  //             Text("Art: ${foodModel?.foodType}"),
  //             Text("Preis: ${foodModel?.price}"),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text("SCHLIEßEN"))
  //         ],
  //       ),
  //     );
}
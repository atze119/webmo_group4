import 'package:flutter/material.dart';
import 'package:webmo_group4/viewmodels/food/food_service.dart';

import '../../models/foodmodel/food_model.dart';

class FoodDialogs {
  late TextEditingController controller;
  static late List<TextEditingController>
      listController; // im not 100% about this static variable
  final FoodService _foodService = FoodService();

  FoodDialogs() {
    listController = [];
    for (var i = 0; i <= 2; i++) {
      listController.add(TextEditingController());
    }
    controller = TextEditingController();
  }

  Future<List<TextEditingController>?> openCreateDialog({
    required BuildContext context,
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
                await _foodService.createFood(listController);
                Navigator.of(context).pop(listController);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "${FoodService.foodModel?.name} wurde zur Datenbank hinzugefügt")));
              },
              child: const Text("HINZUFÜGEN"),
            )
          ],
        ),
      );

  void showFood(
          {required BuildContext context, required FoodModel? foodModel}) =>
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Name: ${foodModel?.name}"),
              Text("Art: ${foodModel?.foodType}"),
              Text("Preis: ${foodModel?.price}"),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("SCHLIEßEN"))
          ],
        ),
      );

  void searchAndShowFood({
    required BuildContext context,
  }) {
    showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Suche"),
        content: TextField(
          autofocus: true,
          decoration: const InputDecoration(hintText: "Essen"),
          controller: controller,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(controller.text);
              await _foodService.setFood(foodName: controller.text);
              showFood(context: context, foodModel: FoodService.foodModel);
            },
            child: const Text("SUCHE"),
          )
        ],
      ),
    );
  }

  Future<List<TextEditingController>?> openUpdateDialog({
    required BuildContext context,
  }) =>
      showDialog<List<TextEditingController>>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Aktualisierung"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(autofocus: true, controller: listController[0]), // == foodName
            TextFormField(controller: listController[1]), // == foodType
            TextFormField(controller: listController[2]), // == price
          ]),
          actions: [
            TextButton(
              onPressed: () async {
                await _foodService.updateFood(listController);
                Navigator.of(context).pop(listController);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "${FoodService.foodModel?.name} wurde Aktualisiert")));
              },
              child: const Text("ÄNDERN"),
            )
          ],
        ),
      );

  Future<String?> searchAndUpdateDialog({
    required BuildContext context,
  }) =>
      showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Welches Gericht möchten Sie ändern"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
                hintText: "Geben Sie den Namen des Gerichts ein"),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _foodService.listControllerUpdate(
                    foodName: controller.text);
                Navigator.pop(context);
                await openUpdateDialog(context: context);
                // TODO deleted Navigator here
              },
              child: const Text("SUCHE"),
            )
          ],
        ),
      );

  Future<String?> deleteFood({
    required BuildContext context,
  }) =>
      showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Entfernen"),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(
                hintText: "Geben Sie den Namen des Gerichtes ein"),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _foodService.deleteFood(foodName: controller.text);
                Navigator.of(context).pop(controller.text);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "${controller.text} wurde aus der Datenbank gelöscht"),
                ));
              },
              child: const Text("LÖSCHEN"),
            )
          ],
        ),
      );
}

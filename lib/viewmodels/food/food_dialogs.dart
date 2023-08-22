import 'package:flutter/material.dart';

import '../../models/foodmodel/food_model.dart';

class FoodDialogs {
  late TextEditingController controller;
  late List<TextEditingController> listController;
  FoodModel? foodModel;

  FoodDialogs() {
    listController = [];
    for (var i = 0; i <= 2; i++) {
      listController.add(TextEditingController());
    }
    controller = TextEditingController();
  }

  Future<String?> openDialog(
          {required BuildContext context,
          required String title,
          required String action,
          required String hintText}) =>
      showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: hintText),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: Text(action),
            )
          ],
        ),
      );

  Future<List<TextEditingController>?> openCreateDialog(
          {required BuildContext context,
          required String title,
          required String action,
          required hintTextName,
          required hintTextType,
          required hintTextPrice}) =>
      showDialog<List<TextEditingController>>(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
                autofocus: true,
                decoration: InputDecoration(hintText: hintTextName),
                controller: listController[0]), // == foodName
            TextField(
                decoration: InputDecoration(hintText: hintTextType),
                controller: listController[1]), // == foodType
            TextField(
                decoration: InputDecoration(hintText: hintTextPrice),
                controller: listController[2]), // == price
          ]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(listController);
              },
              child: Text(action),
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

  Future<List<TextEditingController>?> openUpdateDialog({
    required BuildContext context,
    required String title,
    required String action,
  }) =>
      showDialog<List<TextEditingController>>(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextFormField(
                autofocus: true, controller: listController[0]), // == foodName
            TextFormField(controller: listController[1]), // == foodType
            TextFormField(controller: listController[2]), // == price
          ]),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(listController);
              },
              child: Text(action),
            )
          ],
        ),
      );
}

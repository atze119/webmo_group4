import 'package:flutter/material.dart';
import 'package:webmo_group4/models/repo/database_food.dart';

import '../../models/foodmodel/food_model.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  late TextEditingController controller;
  late List<TextEditingController> listController;
  FoodModel? foodModel;

  @override
  void initState() {
    listController = [];
    for (var i = 0; i <= 2; i++) {
      listController.add(TextEditingController());
    }
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    for (var i = 0; i <= 2; i++) {
      listController[i].dispose();
    }
    controller.dispose();
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
                  listController = (await openCreateDialog(
                      context: context,
                      title: "Essen anlegen",
                      action: "HINZUFÜGEN",
                      hintTextName: "Geben Sie den Namen an",
                      hintTextType: "Geben Sie die Art an",
                      hintTextPrice: "Geben Sie den Preis an"))!;

                  if (listController[0].text.isEmpty ||
                      listController[1].text.isEmpty ||
                      listController[2].text.isEmpty) {
                    return; // TODO implement exception handling with error message on display
                  }
                  // TODO maybe change price to Decimal
                  await DatabaseFood().createNewFood(
                      foodModel: FoodModel(
                          name: listController[0].text,
                          foodType: listController[1].text,
                          price: listController[2].text));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "${foodModel?.name} wurde zur Datenbank hinzugefügt")));
                  // TODO add textfield on display to show Food Attributes
                },
                child: const Text("Essen anlegen")),
            // Food update-button
            TextButton(
                onPressed: () async {
                  final foodName = await openDialog(
                      context: context,
                      title: "Welches Gericht möchten Sie ändern",
                      action: "SUCHE",
                      hintText: "Geben Sie den Namen des Gerichts ein");
                  if (foodName == null || foodName.isEmpty) {
                    return;
                  }
                  final foodModel = await DatabaseFood().getFoodModel(foodName);
                  // put old values in TextFields (dialog)
                  listController[0].text = foodModel.name;
                  listController[1].text = foodModel.foodType;
                  listController[2].text = foodModel.price;
                  await openUpdateDialog(
                    context: context,
                    title: "Aktualisierung",
                    action: "ÄNDERN",
                  );
                  // check for null / empty
                  if (listController[0].text.isEmpty ||
                      listController[1].text.isEmpty ||
                      listController[2].text.isEmpty) {
                    return; // TODO implement exception handling with error message on display
                  }
                  // get new data and update food-information in database
                  DatabaseFood().updateFoodData(
                      foodModel: FoodModel(
                          name: listController[0].text,
                          foodType: listController[1].text,
                          price: listController[2].text));

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${foodModel.name} wurde Aktualisiert")));
                },
                child: const Text("Essen aktualisieren")),
            // show food-information button
            TextButton(
                onPressed: () async {
                  final foodName = await openDialog(
                      context: context,
                      title: "Suche",
                      action: "SUCHE",
                      hintText: "Geben Sie den Namen des Gerichts ein");
                  if (foodName == null || foodName.isEmpty) {
                    return;
                  }
                  final foodModel = await DatabaseFood().getFoodModel(foodName);
                  setState(() => this.foodModel = foodModel);
                  showFood(
                      context: context,
                      foodModel: foodModel); // display food in AlertDialog
                },
                child: const Text("Essen anzeigen")),
            // delete food-button
            TextButton(
                onPressed: () async {
                  final foodName = await openDialog(
                      context: context,
                      title: "Entfernen",
                      action: "LÖSCHEN",
                      hintText: "Geben Sie den Namen des Gerichtes ein");
                  if (foodName == null || foodName.isEmpty) {
                    return;
                  }
                  DatabaseFood().deleteFood(name: foodName);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "${foodModel?.name} wurde aus der Datenbank gelöscht")));
                },
                child: const Text("Essen löschen")),
          ],
        ),
      );

  // TODO these two need to be moved out of view!

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

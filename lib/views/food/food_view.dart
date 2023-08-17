import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../models/foodmodel/food_model.dart';
import '../../models/repo/Database_food.dart';

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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>

     Scaffold(
      appBar: AppBar(title: const Text("Essen"),),
      body: Column(
        children: [
          TextButton(onPressed: () async {
            listController = (await openCreateDialog(context: context, title: "Essen anlegen", action: "HINZUFÜGEN", hintTextName: "Geben Sie den Namen an",
                      hintTextPrice:  "Geben Sie die Art an", hintTextType: "Geben Sie den Preis an"))!;

            if (listController == null || listController[0].text.isEmpty || listController[1].text.isEmpty || listController[2].text.isEmpty) return; // TODO implement exception handling with error message on display
            // TODO maybe change price to Decimal
            DatabaseFood().createNewFood(foodModel: FoodModel(name: listController[0].text, foodType: listController[1].text,price: listController[2].text));
            // TODO add textfield on display to show Food Attributes
          }, child: const Text("Essen anlegen")),
          TextButton(onPressed: () {
            // TODO add function to change data from the dishes. Here and in database_food.dart

          }, child: const Text("Essen ändern")),
          TextButton(onPressed: () async {
            final foodName = await openDialog(context: context, title: "Suche", action: "SUCHE", hintText: "Geben Sie den Namen des Gerichtes ein");
            if (foodName == null || foodName.isEmpty) {
              return;
            }
            final foodModel = await DatabaseFood().getFoodModel(foodName);
            setState(() => this.foodModel = foodModel);
            print(foodModel.price); // TODO test case needs to be deleted
            print(foodModel.name);
            print(foodModel.foodType);

          }, child: const Text("Essen anzeigen")),
          //Align(alignment: Alignment.centerRight, child: Text("${foodModel.name} ${foodModel.foodType} ${foodModel.price}"),),
          TextButton(onPressed: () async {
            final foodName = await openDialog(context: context, title: "Entfernen", action: "LÖSCHEN", hintText: "Geben Sie den Namen des Gerichtes ein");
            if (foodName == null || foodName.isEmpty) {
              return;
            }
            DatabaseFood().deleteFood(name: foodName);
          }, child: const Text("Essen löschen")),
        ],
      ),
    );

  // TODO these two need to be moved out of view!

  Future<String?> openDialog({required BuildContext context, required String title, required String action, required String hintText}) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(title:  Text(title),
        content: TextField(autofocus: true, decoration: InputDecoration(hintText: hintText),
          controller: controller,
        ),
        actions: [TextButton(onPressed: () {
        Navigator.of(context).pop(controller.text);
          }, child: Text(action),)],
      ),
  );

  Future<List<TextEditingController>?> openCreateDialog({required BuildContext context, required String title, required String action,
    required hintTextName, required hintTextType, required hintTextPrice }) => showDialog<List<TextEditingController>>(
    context: context,
    builder: (context) => AlertDialog(content: Column(mainAxisSize: MainAxisSize.min,children: [
      TextField(autofocus: true, decoration: InputDecoration(hintText: hintTextName),controller: listController[0]), // == foodName
      TextField(autofocus: true, decoration: InputDecoration(hintText: hintTextType), controller: listController[1]), // == foodType
      TextField(autofocus: true, decoration: InputDecoration(hintText: hintTextPrice), controller: listController[2]), // == price
      ]),
      actions: [TextButton(onPressed: () {
      Navigator.of(context).pop(listController);
    }, child: Text(action),)],
    ),
  );


}


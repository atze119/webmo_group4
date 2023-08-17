import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../models/foodmodel/food_model.dart';
import '../../models/repo/Database_food.dart';

class Foodview extends StatelessWidget {
  const Foodview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Essen"),),
      body: Column(
        children: [
          TextButton(onPressed: () {
            DatabaseFood().createNewFood(foodModel: FoodModel(name: "Bolognese", foodType: "Vegetarisch",price: "2"));
            // TODO add function
          }, child: const Text("Essen anlegen")),
          TextButton(onPressed: () {
            // TODO add function

          }, child: const Text("Essen ändern")),
          TextButton(onPressed: () async {
            FoodModel foodModel = await DatabaseFood().getFoodModel("Bolognese");
            print(foodModel.price); // TODO test case needs to be deleted
            print(foodModel.name);
            print(foodModel.foodType);
          }, child: const Text("Essen anzeigen")),
          TextButton(onPressed: () {
            DatabaseFood().deleteFood(name: "Bolognese");
          }, child: const Text("Essen löschen")),
        ],
      ),
    );
  }
}


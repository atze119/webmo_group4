import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webmo_group4/models/foodmodel/food_model.dart';
import 'package:webmo_group4/viewmodels/food/food_dialogs.dart';

import '../../models/repo/database_food.dart';

class FoodService {
  final FoodDialogs _foodDialogs = FoodDialogs();

  Future<void> createFood(BuildContext context) async {
    List<TextEditingController>? listController = await _foodDialogs
        .openCreateDialog(
      context: context,
      title: "Essen anlegen",
      action: "HINZUFÜGEN",
      hintTextName: "Geben Sie den Namen an",
      hintTextType: "Geben Sie die Art an",
      hintTextPrice: "Geben Sie den Preis an",
    );

    if (listController![0].text.isEmpty ||
        listController[1].text.isEmpty ||
        listController[2].text.isEmpty) {
      // TODO: Implement exception handling with error message on display
      return;
    }
    await DatabaseFood().createNewFood(
        foodModel: FoodModel(
            name: listController[0].text,
            foodType: listController[1].text,
            price: listController[2].text));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "${listController[0].text} wurde zur Datenbank hinzugefügt")));
  }

  Future<void> updateFood(BuildContext context) async{
    String? foodName = await _foodDialogs.openDialog(
        context: context,
        title: "Welches Gericht möchten Sie ändern",
        action: "SUCHE",
        hintText: "Geben Sie den Namen des Gerichts ein");
    if (foodName == null || foodName.isEmpty) {
      return;
    }
    FoodModel? foodModel = await DatabaseFood().getFoodModel(foodName);
    if(foodModel==null){
      //TODO error handling if FoodModel is null
      return;
    }

    List<TextEditingController>? listController = await _foodDialogs.openUpdateDialog(
      context: context,
      title: "Aktualisierung",
      action: "ÄNDERN",
    );
    // put old values in TextFields (dialog)
    listController![0].text = foodModel.name;
    listController[1].text = foodModel.foodType;
    listController[2].text = foodModel.price;
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
  }

  Future<void> showFood(BuildContext context) async {
    String? foodName = await _foodDialogs.openDialog(
      context: context,
      title: "Suche",
      action: "SUCHE",
      hintText: "Geben Sie den Namen des Gerichts ein",
    );
    if (foodName == null || foodName.isEmpty) {
      return;
    }
    FoodModel? foodModel = await DatabaseFood().getFoodModel(foodName);
    if (foodModel == null) {
      // TODO: Implement error handling if foodModel is null
      return;
    }
    _foodDialogs.showFood(context: context, foodModel: foodModel);
  }

  Future<void> deleteFood(BuildContext context) async {
    String? foodName = await _foodDialogs.openDialog(
      context: context,
      title: "Entfernen",
      action: "LÖSCHEN",
      hintText: "Geben Sie den Namen des Gerichtes ein",
    );
    if (foodName == null || foodName.isEmpty) {
      return;
    }
    await DatabaseFood().deleteFood(name: foodName);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("$foodName wurde aus der Datenbank gelöscht"),
    ));
  }

}
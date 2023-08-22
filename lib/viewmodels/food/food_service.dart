import 'package:flutter/material.dart';
import 'package:webmo_group4/models/foodmodel/food_model.dart';
import 'package:webmo_group4/views/food/food_dialogs.dart';

import '../../models/repo/database_food.dart';

class FoodService {
  static FoodModel? foodModel;

  Future<void> createFood(List<TextEditingController> listController) async {
    if (listController[0].text.isEmpty ||
        listController[1].text.isEmpty ||
        listController[2].text.isEmpty) {
      // TODO: Implement exception handling with error message on display
      return;
    }
    foodModel = FoodModel(
        name: listController[0].text,
        foodType: listController[1].text,
        price: listController[2].text);
    await DatabaseFood().createNewFood(foodModel: foodModel!);
  }

  Future<void> updateFood(List<TextEditingController>? listController) async {
    // check for null / empty
    if (listController![0].text.isEmpty ||
        listController[1].text.isEmpty ||
        listController[2].text.isEmpty) {
      return; // TODO implement exception handling with error message on display
    }
    // get new data and update food-information in database
    foodModel = FoodModel(
        name: listController[0].text,
        foodType: listController[1].text,
        price: listController[2].text);
    await DatabaseFood().updateFoodData(foodModel: foodModel!);
  }

  Future<void> deleteFood({required String foodName}) async {
    await DatabaseFood().deleteFood(name: foodName);
  }

  Future<void> listControllerUpdate({required String foodName}) async {
    await setFood(foodName: foodName); // setting Food which will be changed
    // put old values in TextFields (dialog)
    FoodDialogs.listController[0].text = foodModel!.name;
    FoodDialogs.listController[1].text = foodModel!.foodType;
    FoodDialogs.listController[2].text = foodModel!.price;
  }

  Future<void> setFood({required String foodName}) async {
    foodModel = foodModel = await DatabaseFood().getFoodModel(foodName);
    if (foodModel == null) {
      // TODO: Implement error handling if foodModel is null
      return;
    }
  }
}

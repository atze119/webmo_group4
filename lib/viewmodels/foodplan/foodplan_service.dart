import 'package:flutter/material.dart';

import '../../models/foodmodel/food_model.dart';
import '../../models/repo/database_foodplan.dart';

class FoodPlanService{
  static FoodModel? foodModel;

  Future<void> createFood(List<TextEditingController> listController, String week, String day) async {
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
    await DatabaseFoodPlan().addFoodToPlan(week: week, day: day, foodName: foodModel!.name);
  }



}
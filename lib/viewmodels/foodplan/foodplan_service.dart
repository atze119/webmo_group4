import 'package:flutter/material.dart';

import '../../models/foodmodel/food_model.dart';
import '../../models/repo/database_food.dart';
import '../../models/repo/database_foodplan.dart';
import '../../views/foodplan/foodplan_dialogs.dart';

class FoodPlanService{
  static FoodModel? foodModel;
  static FoodModel? foodModelOld;

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

  Future<FoodModel?> getFoodDetails(int week, String day) async{
    String? foodName = await DatabaseFoodPlan().getFoodNameFromPlan(day: day, week: week);
    if(foodName != null){
      FoodModel? foodDetails = await DatabaseFoodPlan().getFoodDetails(foodName);
      if(foodDetails != null){
        return foodDetails;
      }else{
        //TODO: handle exception
        return null;
      }
    }else{
      //TODO: handle exception
      return null;
    }
  }

  Future<void> deleteFoodFromPlan({required String week, required String day}) async {
    await DatabaseFoodPlan().deleteFoodFromPlan(week: week, day: day);
  }

  Future<void> updateFoodEverywhere(
      {required List<TextEditingController>? listController, required String week, required String day}) async {
    if (listController![0].text.isEmpty ||
        listController[1].text.isEmpty ||
        listController[2].text.isEmpty) {
      return; // TODO implement exception handling with error message on display
    }
    foodModel = FoodModel(
        name: listController[0].text,
        foodType: listController[1].text,
        price: listController[2].text);
    await DatabaseFood().updateFoodDataForFoodPlan(foodModel: foodModel!, foodModelOld: foodModelOld!);
    await DatabaseFoodPlan().updateFoodInFoodPlanCollection(week: week, day: day, newName: foodModel!.name);
  }

  Future<void> listControllerUpdate({required int week, required String day}) async {
    FoodModel? foodModel = await getFoodDetails(week, day);
    foodModelOld = foodModel;
    FoodPlanDialogs.listController[0].text = foodModel!.name;
    FoodPlanDialogs.listController[1].text = foodModel.foodType;
    FoodPlanDialogs.listController[2].text = foodModel.price;
  }

}
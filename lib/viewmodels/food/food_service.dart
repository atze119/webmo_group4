import 'package:webmo_group4/models/foodmodel/food_model.dart';
import 'package:webmo_group4/models/repo/database_food.dart';

class FoodService {
  Future<String> addNewFood(
      {required String foodName,
      required String foodType,
      required String foodPrice}) async {
    FoodModel foodModel =
        FoodModel(name: foodName, foodType: foodType, price: foodPrice);
    await DatabaseFood().createNewFood(foodModel: foodModel);
    return foodModel.name;
  }

  Future<FoodModel> getFood({required String foodName}) async {
    return await DatabaseFood().getFoodModel(foodName);
  }

  void updateFoodData(
      {required String foodName,
      required String foodType,
      required String foodPrice}) async {
    await DatabaseFood().updateFoodData(
        foodModel:
            FoodModel(name: foodName, foodType: foodType, price: foodPrice));
  }

  void deleteFood({required String foodName}) async {
    await DatabaseFood().deleteFood(name: foodName);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../foodmodel/food_model.dart';

class DatabaseFood {
  // final String name, foodType;
  // final Decimal price;
  //
  // DatabaseFood({required this.name, required this.foodType, required this.price});

  // TODO maybe switch this .dart-file to an other place, because of MVVM-Purposes

  final CollectionReference foodCollection =
      FirebaseFirestore.instance.collection("FoodCollection");

  Future<FoodModel?> createNewFood({required FoodModel foodModel}) async {
    final snapshot =
        await foodCollection.where("name", isEqualTo: foodModel.name).get();
    if (snapshot.docs.isEmpty) {
      await foodCollection.add({
        "name": foodModel.name,
        "food_type": foodModel.foodType,
        "price": foodModel.price,
      });
      return foodModel;
    } else {
      return null;
    }
  }

  Future<void> updateFoodData({required FoodModel foodModel}) async {
    final docId = await _getFoodId(name: foodModel.name);
    return await foodCollection.doc(docId).set({
      "name": foodModel.name,
      "food_type": foodModel.foodType,
      "price": foodModel.price,
    });
  }

  Future<void> updateFoodDataForFoodPlan({required FoodModel foodModel, required FoodModel foodModelOld}) async {
    final docId = await _getFoodId(name: foodModelOld.name);
    return await foodCollection.doc(docId).set({
      "name": foodModel.name,
      "food_type": foodModel.foodType,
      "price": foodModel.price,
    });
  }


  Future<void> deleteFood({required String name}) async {
    final docId = await _getFoodId(name: name);
    await foodCollection.doc(docId).delete();
  }

  Future<FoodModel?> getFoodModel(String name) async {
    final snapshot = await foodCollection.where("name", isEqualTo: name).get();
    final foodModel = snapshot.docs
        .map((e) => FoodModel.fromSnapshot(
            e as QueryDocumentSnapshot<Map<String, dynamic>>))
        .single;
    return foodModel;
  }

  Future<String> _getFoodId({required String name}) async {
    final snapshot = await foodCollection.where("name", isEqualTo: name).get();
    final docId = snapshot.docs.single.id;
    return docId;
  }
}

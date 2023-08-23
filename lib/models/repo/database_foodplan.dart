import 'package:cloud_firestore/cloud_firestore.dart';

import '../foodmodel/food_model.dart';

class DatabaseFoodPlan {

  final CollectionReference foodPlanCollection =
  FirebaseFirestore.instance.collection("FoodPlanCollection");

  Future<void> addFoodToPlan(
      {required String week, required String day, required String foodName}) async {
    DocumentReference weekDocument = foodPlanCollection.doc(week);
    DocumentSnapshot weekSnapshot = await weekDocument.get();
    if (!weekSnapshot.exists) {
      await weekDocument.set({day: foodName});
    } else {
      await weekDocument.update({day: foodName});
    }
  }

  Future<String?> getFoodNameFromPlan({required String day, required int week}) async {
    final weekDocument = await FirebaseFirestore.instance.collection("FoodPlanCollection").doc("Woche$week").get();

    if (weekDocument.exists) {
      return weekDocument.data()?[day] as String?;
    }
    return null;
  }

  Future<FoodModel?> getFoodDetails(String foodName) async {
    final snapshot = await FirebaseFirestore.instance.collection("FoodCollection").where("name", isEqualTo: foodName).get();

    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      return FoodModel(
        name: data['name'] as String,
        foodType: data['food_type'] as String,
        price: data['price'] as String,
      );
    }
    return null;
  }




}
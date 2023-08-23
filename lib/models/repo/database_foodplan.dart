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
}
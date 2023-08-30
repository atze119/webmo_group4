import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final String foodName, imagePath, message;
  final double rating;
  ReviewModel(
      {required this.foodName,
      required this.imagePath,
      required this.message,
      required this.rating});

  factory ReviewModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return ReviewModel(
        foodName: data["food_name"],
        imagePath: data["image_path"],
        message: data["message"],
        rating: data["rating"]);
  }
}

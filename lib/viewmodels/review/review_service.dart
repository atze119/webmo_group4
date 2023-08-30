import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewService {
  final CollectionReference reviewCollection =
  FirebaseFirestore.instance.collection("ReviewCollection");

  Stream<QuerySnapshot<Map<String, dynamic>>> getReviews(String foodName) {
    return reviewCollection.doc(foodName).collection('Bewertung').snapshots();
  }
}
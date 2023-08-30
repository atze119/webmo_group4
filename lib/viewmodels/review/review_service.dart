import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:webmo_group4/models/repo/database_review.dart';
import 'package:webmo_group4/models/reviewmodel/review_model.dart';

class ReviewService {
  Stream<QuerySnapshot<Map<String, dynamic>>> getReviews(String foodName) {
    return DatabaseReview().getReviews(foodName);
  }

  ReviewModel getReviewModel(
      {required List<QueryDocumentSnapshot> documents, required int index}) {
    return ReviewModel.fromSnapshot(
        documents[index] as QueryDocumentSnapshot<Map<String, dynamic>>);
  }
}

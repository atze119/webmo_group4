import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:webmo_group4/models/foodmodel/food_model.dart';
import '../../models/reviewmodel/review_model.dart';
import '../../viewmodels/review/review_service.dart';
import 'food_rating_view.dart';

class Reviews extends StatelessWidget {
  final FoodModel foodModel;

  Reviews({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bewertungen: ${foodModel.name}")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: ReviewService().getReviews(foodModel.name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Fehler: ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Text('Noch keine Bewertungen vorhanden...');
                }
                final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final ReviewModel review = ReviewModel.fromSnapshot(documents[index] as QueryDocumentSnapshot<Map<String, dynamic>>);
                    return Card(
                      child: ListTile(
                        title: Text('Sterne: ${review.rating}'),
                        subtitle: Text('Bewertung: ${review.message}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () async {
              final cameras = await availableCameras();
              final firstCamera = cameras.first;

              // ignore: use_build_context_synchronously
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TakePictureScreen(
                    camera: firstCamera,
                    foodName: foodModel.name,
                  ),
                ),
              );
            },
            child: const Text("Bewertung abgeben"),
          ),
        ],
      ),
    );
  }
}

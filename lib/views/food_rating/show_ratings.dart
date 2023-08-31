import 'package:cached_network_image/cached_network_image.dart';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webmo_group4/models/foodmodel/food_model.dart';
import '../../models/reviewmodel/review_model.dart';
import '../../viewmodels/review/review_service.dart';
import 'food_rating_view.dart';

class Reviews extends StatelessWidget {
  final FoodModel foodModel;

  const Reviews({super.key, required this.foodModel});

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
                  return const CircularProgressIndicator();
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Text('Noch keine Bewertungen vorhanden...');
                }
                final List<QueryDocumentSnapshot> documents =
                    snapshot.data!.docs;
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final ReviewModel review = ReviewService()
                        .getReviewModel(documents: documents, index: index);
                    return Card(
                      child: ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: review.imagePath,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          width: 50,
                          height: 50,
                        ),
                        title: RatingBar.builder(
                          ignoreGestures: true,
                          onRatingUpdate: (value) {},
                          initialRating: review.rating, // if this value is changed, change it aswell in "foodRating" - attribute
                          direction: Axis.horizontal,
                          itemSize: 26,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 1),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        subtitle: Text('Bewertung: ${review.message}'),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  color: Colors.transparent,
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  height: MediaQuery.of(context).size.height * 0.7,
                                  child: CachedNetworkImage(
                                    imageUrl: review.imagePath,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    fit: BoxFit.cover,  // Passt das Bild in den Container an
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
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
          ),
        ],
      ),
    );
  }
}

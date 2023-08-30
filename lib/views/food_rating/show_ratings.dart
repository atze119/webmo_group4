import 'package:flutter/material.dart';
import 'package:webmo_group4/models/repo/database_review.dart';

class Reviews extends StatelessWidget {
  const Reviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bewertungen")),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.album),
              title: DatabaseReview().getReviewForFood(foodName: "Bolognese"),
            )
          ],
        ),
      ),
    );
  }
}

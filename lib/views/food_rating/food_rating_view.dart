import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:webmo_group4/models/repo/database_review.dart';
import 'package:webmo_group4/shared/constants.dart';
import 'package:webmo_group4/shared/loading.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen(
      {super.key, required this.camera, required this.foodName});

  final CameraDescription camera;
  final String foodName;

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take a picture"),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Loading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();
            if (!mounted) return;

            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(
                  imagePath: image.path, foodName: widget.foodName),
            ));
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final String foodName;

  const DisplayPictureScreen(
      {super.key, required this.imagePath, required this.foodName});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  double? foodRating = 3;
  String imagePath = "";
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    imagePath = widget.imagePath;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display the Picture"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(
              File(widget.imagePath),
            ),
            sizedBox20,
            const Text(
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                "Bewertung"),
            RatingBar.builder(
              initialRating:
                  3, // if this value is changed, change it aswell in "foodRating" - attribute
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                foodRating = rating;
              },
            ),
            sizedBox20,
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Geben Sie eine Beschreibung zu dem Essen ein"),
            ),
            sizedBox20,
            ElevatedButton(
              onPressed: () async {
                DatabaseReview().addReview(
                    imagePath: imagePath,
                    foodName: widget.foodName, // state foodName attribute
                    rating: foodRating!,
                    reviewMessage: _controller.text);
                Navigator.of(context).popUntil(ModalRoute.withName('/reviews'));
              },
              child: const Text("Absenden"),
            )
          ],
        ),
      ),
    );
  }
}

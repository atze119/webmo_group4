import 'package:flutter/material.dart';
import 'package:webmo_group4/views/food/food_dialogs.dart';

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  late FoodDialogs _foodDialogs;

  @override
  void initState() {
    _foodDialogs = FoodDialogs();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Essen"),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () async {
                  await _foodDialogs.openCreateDialog(context: context);
                },
                child: const Text("Essen anlegen")),
            TextButton(
                onPressed: () async {
                  await _foodDialogs.searchAndUpdateDialog(context: context);
                },
                child: const Text("Essen aktualisieren")),
            TextButton(
                onPressed: () async {
                  _foodDialogs.searchAndShowFood(context: context);
                },
                child: const Text("Essen anzeigen")),
            TextButton(
                onPressed: () async {
                  await _foodDialogs.deleteFood(context: context);
                },
                child: const Text("Essen löschen")),
          ],
        ),
      );
}

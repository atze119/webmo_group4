import 'package:flutter/material.dart';
import 'package:webmo_group4/models/foodmodel/food_model.dart';
import '../../viewmodels/food/food_service.dart';
import '../../viewmodels/foodplan/foodplan_service.dart';

class FoodPlanDialogs {
  late TextEditingController controller;
  static late List<TextEditingController>listController; // im not 100% about this static variable
  final FoodPlanService _foodPlanService = FoodPlanService();
  final FoodService _foodService = FoodService();

  FoodPlanDialogs() {
    listController = [];
    for (var i = 0; i <= 2; i++) {
      listController.add(TextEditingController());
    }
    controller = TextEditingController();
  }

  Future<List<TextEditingController>?> openCreateDialog({
    required BuildContext context, required String week, required String day, required int weekIndex,
  }) =>
      showDialog<List<TextEditingController>>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Essen anlegen"),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
                autofocus: true,
                decoration:
                const InputDecoration(hintText: "Geben Sie den Namen an"),
                controller: listController[0]), // == foodName
            TextField(
                decoration:
                const InputDecoration(hintText: "Geben Sie die Art an"),
                controller: listController[1]), // == foodType
            TextField(
                decoration:
                const InputDecoration(hintText: "Geben Sie den Preis an"),
                controller: listController[2]), // == price
          ]),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  child: const Text("AUS LISTE AUSWÄHLEN"),
                  onPressed: (){
                    Navigator.of(context).pop();
                    FoodPlanDialogs().showSelectFoodFromListDialog(context, day, weekIndex);
                  },
                ),
                TextButton(
                  onPressed: () async {
                    await _foodPlanService.createFood(listController, week, day);
                    await _foodService.createFood(listController);
                    Navigator.of(context).pop(listController);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "${FoodPlanService.foodModel?.name} wurde zur Datenbank hinzugefügt")));
                  },
                  child: const Text("HINZUFÜGEN"),
                )
              ],
            ),
          ],
        ),
      );

  Future<void> showFood({
    required BuildContext context, required String day, required int week})
  => showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: FutureBuilder<FoodModel?>(
              future: _foodPlanService.getFoodDetails(week, day),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Fehler: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('Keine Daten verfügbar');
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Name: ${snapshot.data!.name}"),
                      Text("Art: ${snapshot.data!.foodType}"),
                      Text("Preis: ${snapshot.data!.price}"),
                    ],
                  );
                }
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("SCHLIEßEN"))
            ],
          );
        }
    );

  Future<List<TextEditingController>?> openUpdateDialog({
    required BuildContext context,
    required int week,
    required String day,
  }) async {
    await FoodPlanService().listControllerUpdate(week: week, day: day);
    // ignore: use_build_context_synchronously
    return showDialog<List<TextEditingController>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Aktualisierung"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(autofocus: true, controller: FoodPlanDialogs.listController[0]), // == foodName
              TextFormField(controller: FoodPlanDialogs.listController[1]), // == foodType
              TextFormField(controller: FoodPlanDialogs.listController[2]), // == price
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await _foodPlanService.updateFoodEverywhere(
                    listController: FoodPlanDialogs.listController,
                    week: "Woche$week",
                    day: day);
                Navigator.of(context).pop(FoodPlanDialogs.listController);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${FoodService.foodModel?.name} wurde Aktualisiert")));
              },
              child: const Text("ÄNDERN"),
            ),
          ],
        );
      },
    );
  }

  void showSelectFoodFromListDialog(BuildContext context, String day, int weekIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Wählen Sie ein Essen"),
          content: Container(
            width: double.maxFinite,
            child: FutureBuilder<List<FoodModel>>(
              future: FoodPlanService().getAllFoodFromFoodCollection(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Fehler: ${snapshot.error}");
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("Keine Daten verfügbar");
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(snapshot.data![index].name),
                        onTap: () {
                          FoodPlanService().addFoodFromListToFoodPlanCollection(snapshot.data![index], day, weekIndex);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }







}
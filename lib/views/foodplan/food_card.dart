import 'package:flutter/material.dart';
import 'package:webmo_group4/viewmodels/food/food_service.dart';
import 'package:webmo_group4/viewmodels/foodplan/foodplan_service.dart';
import 'package:webmo_group4/views/food/food_dialogs.dart';
import 'package:webmo_group4/views/foodplan/foodplan_dialogs.dart';

import '../../models/foodmodel/food_model.dart';

class FoodCard extends StatelessWidget {
  final int weekIndex;
  final String day;
  const FoodCard({super.key, required this.day, required this.weekIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue.shade200,
      child: FutureBuilder<FoodModel?>(
        future: FoodPlanService().getFoodDetails(weekIndex+1, day),
          builder: (context, snapshot) {
            String? title;
            Text? subtitle;
            if (snapshot.connectionState == ConnectionState.waiting) {
              title = "Laden...";
            }
            else if (snapshot.hasError) {
              title = "Fehler: ${snapshot.error}";
            }
            else if (snapshot.hasData) {
              title = day;
              subtitle = Text("Name: ${snapshot.data?.name}\nArt: ${snapshot.data?.foodType}\nPreis: ${snapshot.data?.price}");
            }
            else {
              title = "Keine Daten verfügbar";
            }
            return ListTile(
              title: Text(title),
              subtitle: subtitle,
              onTap: (){
                FoodPlanDialogs().showFood(context: context, day: day, week: weekIndex + 1);
              },
              trailing: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () async {
                  FoodPlanDialogs().openCreateDialog(context: context, week: "Woche${weekIndex+1}", day: day);
                },
              ),
            );
          }

      ),
    );
  }
}


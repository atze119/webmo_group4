import 'package:flutter/material.dart';
import 'package:webmo_group4/viewmodels/food/food_service.dart';
import 'package:webmo_group4/viewmodels/foodplan/foodplan_service.dart';
import 'package:webmo_group4/views/food/food_dialogs.dart';
import 'package:webmo_group4/views/foodplan/foodplan_dialogs.dart';

class FoodCard extends StatelessWidget {
  final int weekIndex;
  final String day;
  const FoodCard({super.key, required this.day, required this.weekIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue.shade200,
      child: ListTile(
        title: Text(day),
        subtitle: Text("Name Name Name"),
        onTap: () async{
          //FoodDialogs().showFood(context: context, foodModel: foodModel)
        },
        trailing: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () async {
            FoodPlanDialogs().openCreateDialog(context: context, week: "Woche${weekIndex+1}", day: day);
          },
        ),
      ),
    );
  }
}

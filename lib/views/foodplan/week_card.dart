import 'package:flutter/material.dart';
import 'food_card.dart';
class WeekCard extends StatelessWidget {
  final int weekIndex;
  final VoidCallback onActionCompleted;
  WeekCard({super.key, required this.weekIndex, required this.onActionCompleted});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          title: Text("Woche ${weekIndex+1} "),
        ),
        FoodCard(day: "Montag", weekIndex: weekIndex, onActionCompleted: onActionCompleted),
        FoodCard(day: "Dienstag", weekIndex: weekIndex, onActionCompleted: onActionCompleted),
        FoodCard(day: "Mittwoch", weekIndex: weekIndex, onActionCompleted: onActionCompleted),
        FoodCard(day: "Donnerstag", weekIndex: weekIndex, onActionCompleted: onActionCompleted),
        FoodCard(day: "Freitag", weekIndex: weekIndex, onActionCompleted: onActionCompleted),
      ],
    );
  }
}

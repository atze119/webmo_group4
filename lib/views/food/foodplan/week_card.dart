import 'package:flutter/material.dart';
import 'food_card.dart';
class WeekCard extends StatelessWidget {
  final int weekIndex;
  WeekCard({required this.weekIndex});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ListTile(
          title: Text("Woche ${weekIndex+1} "),
        ),
        FoodCard(day: "Montag", weekIndex: weekIndex),
        FoodCard(day: "Dienstag", weekIndex: weekIndex),
        FoodCard(day: "Mittwoch", weekIndex: weekIndex),
        FoodCard(day: "Donnerstag", weekIndex: weekIndex),
        FoodCard(day: "Freitag", weekIndex: weekIndex),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:webmo_group4/views/food/foodplan/week_card.dart';

class FoodPlan extends StatefulWidget {
  const FoodPlan({super.key});

  @override
  State<FoodPlan> createState() => _FoodPlanState();
}

class _FoodPlanState extends State<FoodPlan> {

  int currentPage = 0;

  void _previousWeek() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
      }
    });
  }

  void _nextWeek() {
    setState(() {
      if (currentPage < 7) {
        currentPage++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Essensplan"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_left),
            onPressed: () {
              _previousWeek();
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_right),
            onPressed: () {
              _nextWeek();
            },
          ),
        ],
      ),
      body: WeekCard(weekIndex: currentPage),
    );
  }
}

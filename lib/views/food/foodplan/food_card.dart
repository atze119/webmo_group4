import 'package:flutter/material.dart';
import 'package:webmo_group4/viewmodels/food/food_service.dart';

class FoodCard extends StatelessWidget {
  final int weekIndex;
  final String day;
  FoodCard({required this.day, required this.weekIndex});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue.shade200,
      child: ListTile(
        title: Text(day),
        subtitle: Text("Name Name Name"),
        onTap: () async{
          await FoodService().showFood(context);
        },
        trailing: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () async {
            await FoodService().createFood(context);
          },
        ),
      ),
    );
  }
}

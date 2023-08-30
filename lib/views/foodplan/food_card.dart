import 'package:flutter/material.dart';
import 'package:webmo_group4/viewmodels/auth/auth_service.dart';
import 'package:webmo_group4/viewmodels/foodplan/foodplan_service.dart';
import 'package:webmo_group4/views/food_rating/show_ratings.dart';
import 'package:webmo_group4/views/foodplan/foodplan_dialogs.dart';
import '../../models/foodmodel/food_model.dart';

class FoodCard extends StatefulWidget {
  final int weekIndex;
  final String day;
  final VoidCallback onActionCompleted;
  const FoodCard({super.key, required this.day, required this.weekIndex, required this.onActionCompleted});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {

  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    isAdmin = AuthService().isAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue.shade200,
      child: FutureBuilder<FoodModel?>(
        future: FoodPlanService().getFoodDetails(widget.weekIndex+1, widget.day),
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
              title = widget.day;
              subtitle = Text("Name: ${snapshot.data?.name}\nArt: ${snapshot.data?.foodType}\nPreis: ${snapshot.data?.price}");
            }
            else {
              title = widget.day;
              subtitle = const Text("Keine Daten verfügbar");
            }
            return ListTile(
              title: Text(title),
              subtitle: subtitle,
              onTap: () {
                if (!snapshot.hasData) {
                  return;
                }else {
                  //FoodPlanDialogs().showFood(context: context, day: widget.day, week: widget.weekIndex + 1);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Reviews(foodModel: snapshot.data!,)));
                }
              },
              trailing: isAdmin
              ? Row(
                mainAxisSize: MainAxisSize.min,
                  children:[
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: (){
                        FoodPlanService().deleteFoodFromPlan(week: "Woche${widget.weekIndex+1}", day: widget.day, onCompleted: widget.onActionCompleted);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () async {
                        if(snapshot.hasData){
                          FoodPlanDialogs().openUpdateDialog(context: context, week: widget.weekIndex+1, day: widget.day, onCompleted: widget.onActionCompleted);
                        }else {
                          FoodPlanDialogs().openCreateDialog(
                              context: context, week: "Woche${widget.weekIndex + 1}", day: widget.day, weekIndex: widget.weekIndex+1, onCompleted: widget.onActionCompleted);
                        }
                      },
                    ),
                  ]
              ):null,
            );
          }
      ),
    );
  }
}


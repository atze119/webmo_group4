import 'package:flutter/material.dart';
import 'package:webmo_group4/viewmodels/auth/auth_service.dart';
import 'package:webmo_group4/viewmodels/auth/authenticate.dart';
import 'package:webmo_group4/views/foodplan/week_card.dart';

class FoodPlan extends StatefulWidget {
  const FoodPlan({super.key});

  @override
  State<FoodPlan> createState() => _FoodPlanState();
}

class _FoodPlanState extends State<FoodPlan> {
  late bool isAdmin;

  @override
  void initState() {
    super.initState();
    isAdmin = AuthService().isAdmin();
  }

  int currentPage = 0;

  void _previousWeek() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  void _nextWeek() {
    if (currentPage < 7) {
      setState(() {
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Essensplan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: () {
              _previousWeek();
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: () {
              _nextWeek();
            },
          ),
          if (!isAdmin)
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0,
              ),
              icon: const Icon(Icons.person),
              label: const Text("Admin"),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Authenticate(),
                ));
              },
            ),
        ],
      ),
      body: WeekCard(
          weekIndex: currentPage,
          onActionCompleted: () {
            setState(() {});
          }),
    );
  }
}

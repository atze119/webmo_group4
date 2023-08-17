import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:webmo_group4/models/user_model.dart';
import "package:webmo_group4/views/food/food_view.dart";
import "package:webmo_group4/views/home/home_user/home_user.dart";

import "../shared/loading.dart";
import "../views/home/home_admin/home_admin.dart";
import "auth/auth_service.dart";
import 'auth/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<UserModel?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else {
          UserModel? user = snapshot.data;
          if (user == null) {
            return Authenticate(); // login screen!
          } else {
            return FutureBuilder<bool>(
              future: authService.isAdmin(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loading();
                } else {
                  bool isAdmin = snapshot.data ?? false;
                  return FoodView();//isAdmin ? HomeAdmin() : HomeUser(); TODO change this for normal use
                }
              },
            );
          }
        }
      },
    );
  }
}

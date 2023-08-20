import 'package:flutter/material.dart';
import 'package:webmo_group4/models/user_model.dart';
import 'package:webmo_group4/views/home/home_admin/home_admin.dart';
import 'package:webmo_group4/views/home/home_user/home_user.dart';
import 'package:webmo_group4/views/welcome/welcome_view.dart';

import '../shared/loading.dart';
import 'auth/auth_service.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return StreamBuilder<UserModel?>(
      stream: authService.user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else {
          UserModel? user = snapshot.data;
          if (user == null) {
            return const WelcomeView(); // Zeige den Willkommens-View, wenn der Benutzer nicht angemeldet ist
          } else {
            return FutureBuilder<bool>(
              future: authService.isAdmin(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loading();
                } else {
                  bool isAdmin = snapshot.data ?? false;
                  return isAdmin ? HomeAdmin() : HomeUser();
                }
              },
            );
          }
        }
      },
    );
  }
}

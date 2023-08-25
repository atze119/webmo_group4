import 'package:flutter/material.dart';
import 'package:webmo_group4/shared/constants.dart';
import '../../shared/loading.dart';
import '../../viewmodels/auth/auth_service.dart';
import '../home/home_admin.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: colorbg1,
            appBar: AppBar(
              backgroundColor: colorbg2,
              elevation: 0,
              title: const Text("Anmelden"),
              actions: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorbg2,
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.person),
                  label: const Text("Registrieren"),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    sizedBox20,
                    TextFormField(
                      decoration: textInputDecoration.copyWith(
                        hintText: "E-Mail",
                      ),
                      validator: (val) =>
                          val!.isEmpty ? "Bitte geben Sie eine gültige E-Mail ein" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    sizedBox20,
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Passwort"),
                      validator: (val) => val!.length < 6
                          ? "Das Passwort muss mindestens 6 Zeichen lang sein"
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                    ),
                    sizedBox20,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorbg2,
                      ),
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _authService
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  "Die Anmeldedaten sind nicht korrekt";
                              loading = false;
                            });
                          }else{
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeAdmin()),
                              (route) => route.isFirst,
                            );
                          }
                        }
                      },
                      child: const Text(
                        "Anmelden",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    sizedBox20,
                    Text(
                      error,
                      style: const TextStyle(color: Colors.red, fontSize: 15.0),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

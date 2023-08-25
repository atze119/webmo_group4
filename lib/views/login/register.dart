import 'package:flutter/material.dart';
import 'package:webmo_group4/shared/constants.dart';
import '../../shared/loading.dart';
import '../../viewmodels/auth/auth_service.dart';
import '../home/home_admin.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";
  String adminCode = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            backgroundColor: colorbg1,
            appBar: AppBar(
              backgroundColor: colorbg2,
              elevation: 0,
              title: const Text("Registrieren"),
              actions: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorbg2,
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.person),
                  label: const Text("Anmelden"),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 50.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      sizedBox20,
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "E-Mail"),
                        validator: (val) =>
                            val!.isEmpty ? "Bitte geben Sie eine Email ein" : null,
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
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            hintText: "Admin-Code"),
                        validator: (val) =>
                            val!.isEmpty ? "Bitte geben sie einen gültigen Admin-Code ein" : null,
                        onChanged: (val) {
                          setState(() => adminCode = val);
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
                            dynamic resultAdmin = await _authService
                                .adminRegisterWithEmailAndPassword(
                                email, password, adminCode);
                            if (resultAdmin == null) {
                              setState(() {
                                error = "Bitte geben Sie eine gültige E-Mail ein";
                                loading = false;
                              });
                            }else{
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeAdmin()),
                                    (route) => false,
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Admin-Konto anlegen",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      sizedBox20,
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        );
  }
}

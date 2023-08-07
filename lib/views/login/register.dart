import 'package:flutter/material.dart';
import 'package:webmo_group4/shared/constants.dart';
import '../../shared/loading.dart';
import '../../viewmodels/auth/auth_service.dart';

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
  bool isAdmin = false;

  //text field state
  String email = "";
  String password = "";
  String error = "";
  String adminCode = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: colorbg1,
      appBar: AppBar(
        backgroundColor: colorbg2,
        elevation: 0,
        title: const Text("Register"),
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorbg2,
              elevation: 0,
            ),
            icon: const Icon(Icons.person),
            label: const Text("Sign in"),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                sizedBox20,
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Email"),
                  validator: (val) => val!.isEmpty ? "Enter an email" : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                sizedBox20,
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Password"),
                  validator: (val) => val!.length < 6 ? "Enter a passwort 6+ chars long" : null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                sizedBox20,
                //Admin Checkbox
                CheckboxListTile(
                  title: const Text("Admin Registration?"),
                  value: isAdmin,
                  onChanged: (value){
                    setState(() => isAdmin = value!);
                  },
                ),
                sizedBox20,
                isAdmin ? TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: "Admin-Code"),
                    validator: (val) => val!.isEmpty ? "Enter an admin code" : null,
                    onChanged: (val){
                      setState(() => adminCode = val);
                    },
                  ) : Container(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorbg2,
                  ),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      setState(() => loading = true);
                      if (isAdmin) {
                        dynamic resultAdmin = await _authService
                            .adminRegisterWithEmailAndPassword(
                            email, password, adminCode);
                        isAdmin = false;
                        if (resultAdmin == null) {
                          setState(() {
                            error =
                            "please supply a valid email and admin code";
                            loading = false;
                          });
                        }
                      } else {
                        dynamic resultUser = await _authService
                            .userRegisterWithEmailAndPassword(email, password);
                        if (resultUser == null) {
                          setState(() {
                            error = "please supply a valid email";
                            loading = false;
                          });
                        }
                      }
                    }
                  },
                  child: const Text(
                    "Sign up",
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
      ),
    );
  }
}

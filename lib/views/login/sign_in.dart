import 'package:flutter/material.dart';
import 'package:webmo_group4/shared/constants.dart';
import '../../shared/loading.dart';
import '../../viewmodels/auth/auth_service.dart';

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
    return loading ? const Loading() : Scaffold(
      backgroundColor: colorbg1,
      appBar: AppBar(
        backgroundColor: colorbg2,
        elevation: 0,
        title: const Text("Sign in"),
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorbg2,
              elevation: 0,
            ),
            icon: const Icon(Icons.person),
            label: const Text("Register"),
            onPressed: (){
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorbg2,
                ),
                onPressed: () async{
                  if(_formkey.currentState!.validate()){
                    setState(() => loading = true);
                    dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = "could not sign in with those credentials";
                        loading = false;
                      });
                    }
                  }
                },
                child: const Text(
                  "Sign in",
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

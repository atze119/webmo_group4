import 'package:firebase_auth/firebase_auth.dart';
import 'package:webmo_group4/models/user_model.dart';
import 'package:webmo_group4/models/repo/database_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String authCode = "123456789";

  //create User obj based on UserCredential
  UserModel? _userFromUserCredential(User? user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      return _userFromUserCredential(user);
    }catch(e){
      print(e.toString());
    }
  }

  //register admin with email and password
  Future adminRegisterWithEmailAndPassword(String email, String password, String authenticationCode) async {
    try{
      if(authenticationCode == authCode ){
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;

        //create new document for user with uid
        await DatabaseAuth(uid: user!.uid).updateAdminData();

        return _userFromUserCredential(user);
      }
    }catch(e){
      print(e.toString());
    }
  }

  //Admin or User?
  bool isAdmin()  {
    bool adminStatus = false;
    final user = _auth.currentUser;
    if(user != null){
      adminStatus = true;
    }
    return adminStatus;
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

}



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

  //auth change user stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromUserCredential(user));
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

  //register user with email and password
  Future userRegisterWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      //create new document for user with uid
      await DatabaseAuth(uid: user!.uid).updateUserData();

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
  Future<bool> isAdmin(String uid) async {
    return await DatabaseAuth(uid: uid).isAdmin();
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



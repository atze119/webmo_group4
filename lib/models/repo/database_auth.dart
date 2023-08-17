import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseAuth {
  final String uid;
  DatabaseAuth({required this.uid});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("UserCollection");
  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection("AdminCollection");

  //update User Data
  Future updateUserData() async {
    return await userCollection.doc(uid).set({
      /*

      specific user-data

       */

      //e.g.

      "uid": uid,
    });
  }

  //update Admin Data
  Future updateAdminData() async {
    return await adminCollection.doc(uid).set({
      /*

      specific admin-data

       */

      //e.g.

      "uid": uid,
    });
  }

  //Admin or User?
  Future<bool> isAdmin() async {
    try {
      final adminCollection =
          FirebaseFirestore.instance.collection("AdminCollection");
      DocumentSnapshot adminDoc = await adminCollection.doc(uid).get();
      return adminDoc.exists;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}

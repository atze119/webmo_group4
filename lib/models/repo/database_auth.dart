import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseAuth {
  final String uid;
  DatabaseAuth({required this.uid});

  final CollectionReference adminCollection =
      FirebaseFirestore.instance.collection("AdminCollection");

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

}

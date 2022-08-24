import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Db {
  static final Db _instance = Db._();
  factory Db() => _instance;
  Db._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // get user_name with document id
  Future<void> setUserName(String name) async {
    try {
      await auth.currentUser?.updateDisplayName(name);
      await firestore
          .collection('Users')
          .doc(auth.currentUser?.uid)
          .set(<String, dynamic>{'user_name': name});
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getData() async* {
    firestore.collection('Users').orderBy('creation', descending: true).snapshots();
    // await db.collection('Users').get().asStream();
    //     .then((QuerySnapshot<Map<String, dynamic>> event) {
    //   for (QueryDocumentSnapshot<Map<String, dynamic>> doc in event.docs) {
    //     print('${doc.id} => ${doc.data()}');
    //   }
    // });
  }

  Future<void> putCarData(
      {required String name,
      required String model,
      required String color,
      required String number}) async {
    try {
      if (name.isEmpty || model.isEmpty || color.isEmpty || number.isEmpty) {
        throw Exception('Please fill all fields.');
      }
      if (number.length > 10) {
        throw Exception('Car number must be 10 digits.');
      }
      CollectionReference<Map<String, dynamic>> a =
          firestore.collection('Users').doc(auth.currentUser?.uid).collection('Cars');
      QuerySnapshot<Map<String, dynamic>> b = await a.get();
      log('${b.docs.length}');
      await a.doc(name).set(<String, dynamic>{
        'name': name,
        'model': model,
        'color': color,
        'number': number.toUpperCase()
      });
    } catch (e) {
      throw e.toString();
    }
  }
}

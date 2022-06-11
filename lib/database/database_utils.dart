import 'dart:ffi';

import 'package:chat/model/myuser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseUtils {
  static CollectionReference<MyUser> getUsercollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());
  }

  static Future<void> createDBUser(MyUser user) async {
    getUsercollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readuser(String userID) async {
    var userDocSnapshot = await getUsercollection().doc(userID).get();
    userDocSnapshot.data();
  }
}

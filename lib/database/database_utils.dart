import 'dart:ffi';

import 'package:chat/model/message.dart';
import 'package:chat/model/myuser.dart';
import 'package:chat/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseUtils {
  static CollectionReference<MyUser> getUsercollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, options) =>
                MyUser.fromJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());
  }

  static CollectionReference<Room> getRoomscollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (snapshot, options) =>
                Room.fromJson(snapshot.data()!),
            toFirestore: (Room, _) => Room.toJson());
  }

  static CollectionReference<Massage> getMessagecollection(String roomId) {
    return getRoomscollection()
        .doc(roomId)
        .collection(Massage.collectionName)
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Massage.fromJson(snapshot.data()!),
            toFirestore: (massage, _) => massage.toJson());
  }

  static Future<void> createDBUser(MyUser user) async {
    getUsercollection().doc(user.id).set(user);
  }

  static Future<MyUser?> readUser(String userId) async {
    var userDocSnapshot = await getUsercollection().doc(userId).get();
    return userDocSnapshot.data();
  }

  static Future<void> createroom(
      String title, String desc, String catId) async {
    var roomCollection = getRoomscollection();
    var docref = roomCollection.doc();
    Room room = Room(id: docref.id, title: title, desc: desc, catId: catId);
    return docref.set(room);
  }

  static Future<List<Room>> getRoomsFromFirestore() async {
    var getroom = await getRoomscollection().get();
    return getroom.docs.map((e) => e.data()).toList();
  }

  static Future<void> insertMessageToRoom(Massage massage) async {
    var roomsMassages = getMessagecollection(massage.roomId);
    var docRef = roomsMassages.doc();
    massage.id = docRef.id;
    return docRef.set(massage);
  }

  static Stream<QuerySnapshot<Massage>> getMassageStream(String roomID) {
    return getMessagecollection(roomID).orderBy("dateTime").snapshots();
  }
}

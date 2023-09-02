import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zoom_clone/presentation/utils/utils.dart';

class FirestoreMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistory =>
      firestore.collection('users').doc(auth.currentUser!.uid).collection('meetings').snapshots();

  Future<void> addUser({
    required BuildContext context,
    required String? username,
    required String uid,
    required String? photoURL,
    required phoneNumber,
  }) async {
    try {
      await firestore.collection('users').doc(uid).set({
        'username': username,
        'uid': uid,
        'profilepic': photoURL,
        'mobile': phoneNumber,
      });
    } on FirebaseException catch (e) {
      if (context.mounted) {
        Utils.showSnackBar(context: context, text: e.message!);
      }
    }
  }

  Future<void> addToMeetingHistory({required String meetingName}) async {
    String id = const Uuid().v1();
    try {
      await firestore.collection('users').doc(auth.currentUser!.uid).collection('meetings').doc(id).set(
        {
          'meetingName': meetingName,
          'createdAt': DateTime.now(),
          'photoUrl': auth.currentUser!.photoURL,
          'id': id,
        },
      );
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }

  Future<void> deleteSingleMeetInHistory({required String id}) async {
    try {
      await firestore.collection('users').doc(auth.currentUser!.uid).collection('meetings').doc(id).delete();
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }
}

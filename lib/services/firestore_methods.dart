// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/utils/utils.dart';

class FirestoreMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

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
      Utils.showSnackBar(context: context, text: e.message!);
    }
  }

  Future<void> addToMeetingHistory({required String meetingName}) async {
    try {
      await firestore.collection('users').doc(auth.currentUser!.uid).collection('meetings').add(
        {
          'meetingName': meetingName,
          'createdAt': DateTime.now(),
        },
      );
    } on FirebaseException catch (e) {
      log(e.message!);
    }
  }
}

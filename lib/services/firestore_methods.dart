// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/presentation/utils/utils.dart';

class FirestoreMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
}

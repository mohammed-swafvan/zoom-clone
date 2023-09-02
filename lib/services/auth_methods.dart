// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/presentation/utils/utils.dart';
import 'package:zoom_clone/services/firestore_methods.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => auth.authStateChanges();
  User get user => auth.currentUser!;

  bool isLoading = false;

  Future<bool> signInWithGoogle(BuildContext context) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential = await auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await FirestoreMethods().addUser(
            context: context,
            username: user.displayName,
            uid: user.uid,
            photoURL: user.photoURL,
            phoneNumber: user.phoneNumber,
          );
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(context: context, text: e.message!);
      res = false;
    }
    return res;
  }

  Future<void> signOut() async{
    try {
      await auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}

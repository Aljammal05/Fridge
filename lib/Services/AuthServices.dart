import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fridge/Dialogs/Dialogs.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<bool> signUp(String email, String password, context) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? signedIn = authResult.user;
      if (signedIn != null) {
        return true;
      }
      return false;
    } catch (e) {
      Navigator.pop(context);
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => ErrorDialog(
          action: (){Navigator.pop(context);},
          title: 'ERROR',
          text: e.toString(),
        ),
      );
      return false;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Logout() async{
   await FirebaseAuth.instance.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServices extends ChangeNotifier {
  static final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get uset => _user!;

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if(googleUser==null)return;
    _user =googleUser;
    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    notifyListeners();
  }

  static googleLogout() async{
    await googleSignIn.signOut();
  }
}

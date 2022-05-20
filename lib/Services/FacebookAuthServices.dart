import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthServices{

  static Future facebookLogin() async{
    try{
      final facebookLoginResult =await FacebookAuth.instance.login();
      final facebookAuthCredential = FacebookAuthProvider.credential(facebookLoginResult.accessToken!.token);
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);

    }catch(e){
      print(e.toString());
    }

  }

  static facebookLogout() async{
   await FacebookAuth.instance.logOut();
  }

}
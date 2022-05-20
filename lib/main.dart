import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fridge/Services/GoogleAuthServices.dart';
import 'package:fridge/WelcomePage.dart';
import 'package:provider/provider.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (context) => GoogleAuthServices(),
      child: MaterialApp(
        home: SafeArea(child:WelcomePage()
        ),
      ),
    );
  }
}
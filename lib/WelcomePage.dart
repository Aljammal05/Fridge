import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fridge/SignInPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SafeArea(child: SignInPage());
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: <Color>[Color(0xff85FDFA), Color(0xff1F2CD3)],
        tileMode: TileMode.repeated,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'image/logo.png',
                height: 180,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
              Image(
                image: const AssetImage("image/welcome1.png"),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              )
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fridge/Dialogs/Dialogs.dart';
import 'package:fridge/templates/templates.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({Key? key}) : super(key: key);

  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  String _email = '';
  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      floatingButton: false,
      child: Material(
        elevation: 6,
        borderRadius: const BorderRadius.all(
          Radius.circular(30),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width - 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Text(
                      "Reset Password",
                      style: TextStyle(fontSize: 25,color: Colors.blue),
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: const Text(
                        "Please enter your email to receive the reset password link : ",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(height: 10,),
                    BuildTextField(
                      hint: "Enter your email",
                      isPassword: false,
                      function: (val) {
                        _email = val;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 35.0),
                      child: GestureDetector(
                        onTap: () async {
                          if (_email.isEmpty) {
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => ErrorDialog(
                                action: (){Navigator.pop(context);},
                                title: 'Sorry',
                                text:
                                'All of fields are required,\nplease fill all of them.',
                              ),
                            );
                          } else {
                            FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
                            showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => ErrorDialog(
                                action: (){Navigator.pop(context);
                                Navigator.pop(context);},
                                title: 'SUCCESS',
                                text:
                                'The reset email sent successfully, please check your email',
                                buttonTitle: "OK",
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: 200,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "SEND",
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

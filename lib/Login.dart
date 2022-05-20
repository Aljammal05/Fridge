import 'package:flutter/material.dart';
import 'package:fridge/Dialogs/Dialogs.dart';
import 'package:fridge/RecoveryPage.dart';
import 'package:fridge/ScanPage.dart';
import 'package:fridge/Services/AuthServices.dart';
import 'package:fridge/templates/templates.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BuildTextField(
          hint: "Enter your email",
          isPassword: false,
          function: (val) {
            _email = val;
          },
        ),
        BuildTextField(
          hint: "Password",
          isPassword: true,
          obscureText: true,
          function: (val) {
            _password = val;
          },
        ),
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SafeArea(child: RecoveryPage());
                      },
                    ),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: GestureDetector(
            onTap: () async {
              if (_email.isEmpty || _password.isEmpty) {
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
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => WaitingDialog(),
                );
                bool isValid =
                await AuthService.signIn(_email, _password);

                if (isValid) {

                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SafeArea(
                          child: ScanPage(),
                        );
                      },
                    ),
                  );
                } else {
                  Navigator.pop(context);
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => ErrorDialog(
                      action: (){Navigator.pop(context);},
                      title: 'Wrong Input',
                      text:
                      'This email or password is wrong.\nPlease try again.',
                    ),
                  );
                }
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
                  "LOGIN",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

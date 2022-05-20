import 'package:flutter/material.dart';
import 'package:fridge/Dialogs/Dialogs.dart';
import 'package:fridge/Services/AuthServices.dart';
import 'package:fridge/templates/templates.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email = '', _password = '', _confirmPassword = '';

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
        BuildTextField(
          hint: "Confirm Password",
          isPassword: true,
          obscureText: true,
          function: (val) {
            _confirmPassword = val;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: GestureDetector(
            onTap: () async {
              print(_email+_password+_confirmPassword);
              if (_email.isEmpty ||
                  _password.isEmpty ||
                  _confirmPassword.isEmpty) {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ErrorDialog(
                    title: 'Sorry',
                    text:
                        'All of fields are required,\nplease fill all of them.',
                    action: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              } else if (_password.length < 8) {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ErrorDialog(
                    title: 'Invalid Password',
                    text:
                        'Please make sure your password \ncontain 8 digits or more',
                    action: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              } else if (_password != _confirmPassword) {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ErrorDialog(
                    title: 'Doesn\'t Match',
                    text: 'Please make sure your \npasswords are match',
                    action: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              } else {
                showDialog<void>(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => WaitingDialog(),
                );
                bool isValid =
                    await AuthService.signUp(_email, _password, context);
                if (isValid) {
                  Navigator.pop(context);
                  showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => ErrorDialog(
                      title: "SUCCESS",
                      text: "Your account has been\n"
                          "created successfully.",
                      buttonTitle: "OK THANKS",
                      action: () {
                        Navigator.pop(context);
                      },
                    ),
                  );
                } else {
                  print('something wrong');
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
                  "SIGN UP",
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

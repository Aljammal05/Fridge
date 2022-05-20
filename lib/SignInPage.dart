import 'package:flutter/material.dart';
import 'package:fridge/Login.dart';
import 'package:fridge/ScanPage.dart';
import 'package:fridge/Services/FacebookAuthServices.dart';
import 'package:fridge/Services/GoogleAuthServices.dart';
import 'package:fridge/SignUp.dart';
import 'package:fridge/templates/templates.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _toggle = true;
  final List<String> _values = ['Login', 'Sign Up'];
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
          height: MediaQuery.of(context).size.height / 1.6,
          width: MediaQuery.of(context).size.width - 70,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  AnimatedToggle(),
                  SizedBox(
                    height: 20,
                  ),
                  _toggle ? LoginPage() : SignUpPage(),
                  Text(
                    "Or",
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            final provider = Provider.of<GoogleAuthServices>(context,listen: false);
                            provider.googleLogin();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SafeArea(child: ScanPage());
                                },
                              ),
                            );
                          },
                          child: Image(
                            image: AssetImage('image/google.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:  GestureDetector(
                          onTap: () {
                            FacebookAuthServices.facebookLogin();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SafeArea(child: ScanPage());
                                },
                              ),
                            );
                          },
                          child: Image(
                            image: AssetImage('image/facebook.png'),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget AnimatedToggle() {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.all(Radius.circular(45)),
      child: Container(
        width: 250,
        height: 50,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(45))),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _toggle = !_toggle;
                });
              },
              child: Container(
                width: 250,
                height: 50,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    2,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        _values[index],
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
              alignment: _toggle ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 250 * 0.5,
                height: 50,
                decoration: ShapeDecoration(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
                child: Center(
                  child: Text(
                    _toggle ? _values[0] : _values[1],
                    style: TextStyle(
                      fontFamily: 'Rubik',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

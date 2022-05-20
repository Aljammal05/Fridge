
import 'package:flutter/material.dart';
import 'package:fridge/Services/AuthServices.dart';
import 'package:fridge/Services/FacebookAuthServices.dart';
import 'package:fridge/Services/GoogleAuthServices.dart';

class BuildTextField extends StatefulWidget {
  BuildTextField({this.obscureText = false,required this.hint,required this.isPassword,required this.function});
  String hint ;
  bool isPassword;
  Function function ;
  bool obscureText;
  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {

  var _color ;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0 ,vertical: 8),
      child: TextField(
        onChanged: (String val) {
          widget.function(val);
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: const TextStyle(fontSize: 18,
                color: Colors.grey),
            suffixIcon: widget.isPassword?GestureDetector(
                onTap: (){
                  setState(() {
                    if (_color == Colors.grey) {
                      _color  = Colors.blue;
                      widget.obscureText = false;
                    } else {
                      _color  = Colors.grey;
                      widget.obscureText = true;
                    }

                  });
                },
                child: Icon(Icons.visibility,color: _color,)
            ):Container(height: 0,width: 0,)
        ),
      ),
    );
  }
}



class BackgroundPage extends StatelessWidget {
  BackgroundPage({required this.child,required this.floatingButton});

  Widget child;
  bool floatingButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Image(
                image: AssetImage('image/signIn1.png'),
              ),
              Image(
                image: AssetImage('image/signIn2.png'),
              )
            ],
          ),
          const Positioned(
            bottom: -100,
            right: -100,
            child: Image(
              image: AssetImage('image/signIn3.png'),
              height: 270,
              width: 270,
            ),
          ),
          Center(
            child: child,
          )
        ],
      ),
      floatingActionButton: floatingButton?FloatingActionButton(child: Icon(Icons.logout),onPressed: (){
        GoogleAuthServices.googleLogout();
        FacebookAuthServices.facebookLogout();
        AuthService.Logout();
        Navigator.pop(context);
      }):Container(),
    );
  }
}

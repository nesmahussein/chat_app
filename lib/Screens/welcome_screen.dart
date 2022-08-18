// ignore_for_file: library_private_types_in_public_api

import 'package:chatting_app/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widget/mybutton.dart';

class WelcomeScreen extends StatefulWidget {

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset('images/logo.png',width:150),
                ),
                Text(
                  'Message Me',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Constant.color1),
                )
              ],
            ),
            SizedBox(height: 30,),
            MyBUtton('Sign In', (){
              Navigator.pushNamed(context, Constant.SignInScreenRoute);
            }, Constant.color1),
            SizedBox(height: 10,),
            MyBUtton('Sign Up' , (){
              Navigator.pushNamed(context, Constant.SignUpScreenRoute);
            },Constant.color2),
          ],
        ),
      ),
    );
  }
}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}



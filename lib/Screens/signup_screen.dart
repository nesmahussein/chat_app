import 'package:chatting_app/constant.dart';
import 'package:chatting_app/widget/mybutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widget/mytextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  String? firstName;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: Constant.showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 180,
                child: Image.asset('images/logo.png'),
              ),
              SizedBox(
                height: 30,
              ),
              myTextField(Constant.color2, (value) {
                firstName = value;
              }, 'First Name', Constant.color1, false),
              SizedBox(
                height: 10,
              ),
              myTextField(Constant.color2, (value) {
                email = value;
              }, 'Enter your Email', Constant.color1, false),
              SizedBox(
                height: 10,
              ),
              myTextField(Constant.color2, (value) {
                password = value;
              }, 'Enter your Password', Constant.color1, true),
              SizedBox(height: 20),
              MyBUtton('Sign Up', () async {
                setState(() {
                  Constant.showSpinner=true;
                });
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email!, password: password!);
                  Navigator.pushNamed(context, Constant.chattingScreenRoute);
                  setState(() {
                  Constant.showSpinner =false;
                  });

                } catch (e) {
                  print(e);
                }
              }, Constant.color2)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:chatting_app/constant.dart';
import 'package:chatting_app/widget/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widget/mytextfield.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                email = value;
              }, 'Enter your Email', Constant.color1, false),
              SizedBox(
                height: 10,
              ),
              myTextField(Constant.color2, (value) {
                password = value;
              }, 'Enter your Password', Constant.color1, true),
              SizedBox(height: 20),
              MyBUtton('Sign In', () async {
                try {
                  setState(() {
                    Constant.showSpinner=true;
                  });

                  final user = await _auth.signInWithEmailAndPassword(
                      email: email!, password: password!);
                  if (user != null) {
                    Navigator.pushNamed(context, Constant.chattingScreenRoute);
                    setState(() {
                      Constant.showSpinner=false;
                    });
                  }
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

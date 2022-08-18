import 'package:chatting_app/Screens/chat_screen.dart';
import 'package:chatting_app/Screens/signup_screen.dart';
import 'package:chatting_app/Screens/welcome_screen.dart';
import 'package:chatting_app/constant.dart';
import 'package:flutter/material.dart';
import 'Screens/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final _auth=FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' Chatting App',

     // home:ChattingScreen(),
      initialRoute: _auth.currentUser !=null ?Constant.chattingScreenRoute:Constant.SignInScreenRoute,
      routes: {
        Constant.WelcomeScreenRoute : (context) => WelcomeScreen(),
        Constant.SignInScreenRoute: (context) => SignInScreen(),
        Constant.SignUpScreenRoute : (context) => SignUpScreen(),
        Constant.chattingScreenRoute : (context) => ChattingScreen(),

      },
    );
  }
}


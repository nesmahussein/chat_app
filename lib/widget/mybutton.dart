import 'package:chatting_app/constant.dart';
import 'package:flutter/material.dart';

class MyBUtton extends StatelessWidget{
  final String title;
  final VoidCallback onPressed;
  final Color color;
  MyBUtton( this.title, this.onPressed, this.color);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
          elevation: 6,
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: MaterialButton(
            onPressed:onPressed  ,
            minWidth: 200,

            height: 30,
            child: Text(title,style:TextStyle(color: Colors.white),
            ),
          )),
    );
  }


}
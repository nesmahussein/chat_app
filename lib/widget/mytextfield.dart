import 'package:flutter/material.dart';
class myTextField extends StatelessWidget{
  final Color colorFocus;
  final Color colorStable;
  final void Function(String?) onFocus;
  final String title;
  final bool obsecure;

   myTextField(this.colorFocus, this.onFocus, this.title, this.colorStable,  this.obsecure);
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      obscureText:obsecure,
      textAlign: TextAlign.center,
      onChanged:onFocus,
      decoration: InputDecoration(
        hintText: title,
        contentPadding:
        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorStable, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorFocus, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

}


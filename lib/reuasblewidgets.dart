// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

Image imgWidget(String imageName, double h, double w) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: w,
    height: h,
  );
}

TextField reuasbleTextField(
    String hintTxt, IconData icon, bool isPass, TextEditingController cont) {
  return TextField(
    textAlign: TextAlign.right,
    controller: cont,
    obscureText: isPass,
    enableSuggestions: !isPass,
    autocorrect: !isPass,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.deepPurple,
      ),
      hintText: hintTxt,
      hintStyle: TextStyle(color: Colors.grey),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      filled: true,
    ),
    keyboardType:
        isPass ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

Widget signInBtn(BuildContext context, String text, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 110,
    padding: EdgeInsets.symmetric(vertical: 25),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
    child: ElevatedButton(
        onPressed: () {
          onTap();
        },
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.deepPurple;
            }
            return Colors.deepPurple;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
        )),
  );
}

Widget forgotPassBtn() {
  return Container(
    alignment: Alignment.centerRight,
    child: TextButton(
        onPressed: () {},
        // padding: EdgeInsets.only(right: 0),
        child: Text(
          'هل نسيت كلمة المرور؟',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        )),
  );
}

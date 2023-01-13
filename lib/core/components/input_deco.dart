import 'package:flutter/material.dart';

InputDecoration myInputDec(String? hint) {
  return InputDecoration(
    filled: true,
    fillColor: Color(0xFFF4F4FF),
    contentPadding: EdgeInsets.all(16.0),
    hintText: hint,
    hintStyle: TextStyle(
        fontStyle: FontStyle.normal,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(9, 9, 55, 0.4)),
    labelStyle: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
      borderRadius: BorderRadius.circular(4.0),
    ),
    floatingLabelStyle: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black, width: 1.5),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

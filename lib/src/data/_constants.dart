import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xfff2f2f2);

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xffFBFBFB),
  contentPadding: EdgeInsets.all(8),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(25.0),
    ),
    borderSide: BorderSide(color: Color(0xffF9F9F9)),
  ),
);

const kTitleDecoration = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

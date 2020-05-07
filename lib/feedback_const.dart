import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  filled: true,
  fillColor: Color(0xffFBFBFB),
  contentPadding: EdgeInsets.all(10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(35.0),
    ),
    borderSide: BorderSide(color: Color(0xffF9F9F9)),
  ),
);

const kTitleDecoration = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w600,
  color: Colors.black,
);

class CustomButton extends StatelessWidget {
  CustomButton({@required this.fillText, this.onPressed});

  final String fillText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      width: 320.0,
      child: FlatButton(
          color: Colors.white,
          textColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            fillText,
            style: TextStyle(fontSize: 16.0),
          ),
          onPressed: () {
            onPressed();
          }),
    );
  }
}

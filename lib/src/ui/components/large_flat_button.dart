import 'package:flutter/material.dart';

class LargeFlatButton extends StatelessWidget {
  LargeFlatButton({@required this.fillText, this.onPressed});

  final String fillText;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      width: 310.0,
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

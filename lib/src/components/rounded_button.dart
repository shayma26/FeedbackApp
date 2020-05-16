import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {@required this.onPressed,
      @required this.label,
      this.labelSize = 20.0,
      this.width = 115,
      this.elevation = 7.0,
      this.labelWeight = FontWeight.w600});
  final double elevation;
  final Function onPressed;
  final String label;
  final double labelSize;
  final double width;
  final FontWeight labelWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: RaisedButton(
        child: Container(
          width: width,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: labelSize,
              fontWeight: labelWeight,
            ),
          ),
        ),
        onPressed: onPressed,
        color: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 13.0, horizontal: 13.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23.0),
        ),
        elevation: elevation,
      ),
    );
  }
}

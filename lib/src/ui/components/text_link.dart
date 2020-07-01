import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  TextLink(
      {@required this.text,
      @required this.onTap,
      this.horizontalPadding = 0.0,
      this.verticalPadding = 10.0,
      this.textSize = 16.0});
  final String text;
  final double textSize;
  final Function onTap;
  final double horizontalPadding;
  final double verticalPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: GestureDetector(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blue,
            fontSize: textSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

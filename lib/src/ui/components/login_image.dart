import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 72.0, left: 72, right: 72, bottom: 150),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Text(
            'Welcome\nBack!',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Color(0xff4196FD),
            ),
          ),
          Positioned(
            top: 35,
            right: 0,
            height: 150,
            child: Image.asset(
              'images/welcome_image.png',
            ),
          ),
        ],
      ),
    );
  }
}

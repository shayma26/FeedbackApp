import 'package:flutter/material.dart';

class ImportantTitle extends StatelessWidget {
  ImportantTitle(
      {this.biggerTitleColor = Colors.blue,
      this.bigTitleColor = Colors.blue,
      this.verticalPadding = 100,
      this.biggerTitle = 'Bigger Title',
      this.bigTitle = 'Big title'});

  final String biggerTitle;
  final String bigTitle;
  final double verticalPadding;
  final Color biggerTitleColor;
  final Color bigTitleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Column(
        children: <Widget>[
          Text(
            biggerTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            bigTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue[400],
              fontSize: 25.0,
            ),
          ),
        ],
      ),
    );
  }
}

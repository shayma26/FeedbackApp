import 'package:flutter/material.dart';
import 'my_home_page.dart';

void main() => runApp(AskForFeedback());

class AskForFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ask For Feedback',
      theme: ThemeData(fontFamily: 'Poppins'),
      home: MyHomePage(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:askforfeedback/feedback_const.dart';
import '../components/important_title.dart';
import '../components/rounded_button.dart';

class NoReceivedFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: <Widget>[
          ImportantTitle(
            biggerTitle: 'Received Feedback',
            bigTitle: 'No Feedback yet',
            verticalPadding: 70,
          ),
          Expanded(child: Center(child: Image.asset('images/nofeedback.png'))),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: RoundedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'sendfeedback');
              },
              label: 'Give Feedback',
              labelSize: 17,
              width: 170,
            ),
          ),
        ],
      ),
    );
  }
}

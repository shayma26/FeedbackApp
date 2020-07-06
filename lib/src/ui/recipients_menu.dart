import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/users_stream.dart';

String selectedRecipient;

class RecipientsMenu extends StatefulWidget {
  @override
  _RecipientsMenuState createState() => _RecipientsMenuState();
}

class _RecipientsMenuState extends State<RecipientsMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff737373),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffF3F2F3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 18.0),
              child: Text(
                'Choose a recipent',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            UsersStream(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/register_image.dart';
import 'login.dart';
import 'components/text_link.dart';
import 'package:askforfeedback/src/data/_constants.dart';
import 'components/register_form.dart';

class Register extends StatefulWidget {
  static String id = 'registration';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(children: <Widget>[
        Hero(tag: 'welcome', child: RegisterImage()),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(23)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              //ShowAlert(),
              SignUpForm(),
              login(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget login() {
    return TextLink(
      text: 'Have an account? Login ▸',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return LogIn();
            },
          ),
        );
      },
    );
  }
}

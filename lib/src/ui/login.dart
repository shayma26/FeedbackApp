import 'package:askforfeedback/src/ui/components/log_in_form.dart';
import 'package:flutter/material.dart';
import 'components/login_image.dart';
import 'registration.dart';
import 'package:askforfeedback/src/data/_constants.dart';
import 'components/text_link.dart';

class LogIn extends StatefulWidget {
  static String id = 'login';
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: <Widget>[
          Hero(tag: 'welcome', child: LoginImage()),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(23)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SignInForm(),
                signup(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget signup() {
    return TextLink(
        text: 'Don\'t have an account? Create one ▸',
        onTap: () {
          Navigator.pushNamed(context, Register.id);
        });
  }
}

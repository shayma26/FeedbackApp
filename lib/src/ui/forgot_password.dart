import 'package:askforfeedback/src/ui/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:askforfeedback/feedback_const.dart';
import 'package:flutter/widgets.dart';
import '../components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgotpassword';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

final _auth = FirebaseAuth.instance;

class _ForgotPasswordState extends State<ForgotPassword> {
  String _warning;

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 13.0),
        color: Colors.blue,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                _warning,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Image.asset('images/forgot_password.png'),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(23.0),
                    topLeft: Radius.circular(23.0)),
              ),
              child: Column(
                children: <Widget>[
                  showAlert(),
                  Row(
                    children: <Widget>[
                      IconButton(
                          alignment: Alignment.centerLeft,
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.pushNamed(context, LogIn.id);
                          }),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                      Text(
                        'Forgot Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'Enter the E-mail address associated with your account',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ),
                  Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidate: true,
                      controller: email,
                      decoration: InputDecoration(
                          filled: true,
                          hintText: 'mail@example.com',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 7.0, horizontal: 30),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30.0),
                    child: RoundedButton(
                      onPressed: () {
                        _auth.sendPasswordResetEmail(email: email.text);

                        Navigator.pop(context);
                      },
                      label: 'Reset Password',
                      width: MediaQuery.of(context).size.width * 0.55,
                      labelWeight: FontWeight.w500,
                      elevation: 0.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

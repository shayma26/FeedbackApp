import 'package:flutter/material.dart';
import 'registration.dart';
import 'no_received_feedback.dart';
import 'received_feedback.dart';
import 'package:askforfeedback/src/data/_constants.dart';
import 'components/custom_text_field.dart';
import 'components/rounded_button.dart';
import 'components/text_link.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'forgot_password.dart';
import 'components/showAlert.dart';

class LogIn extends StatefulWidget {
  static String id = 'login';
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  List<Map<String, dynamic>> receivedFeedback = [];

  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  FirebaseUser _loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: <Widget>[
            Hero(
              tag: 'welcome',
              child: Container(
                margin: EdgeInsets.only(
                    top: 72.0, left: 72, right: 72, bottom: 150),
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
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(23)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ShowAlert(),
                  CustomTextField(
                    labelController: _emailController,
                    labelName: 'Email',
                    textType: TextInputType.emailAddress,
                  ),
                  CustomTextField(
                    labelController: _passwordController,
                    labelName: 'Password',
                    obscure: true,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextLink(
                      text: 'Forgot Password',
                      verticalPadding: 0.0,
                      textSize: 14.0,
                      onTap: () {
                        Navigator.pushNamed(context, ForgotPassword.id);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RoundedButton(
                    label: 'Login',
                    labelSize: 18.0,
                    width: 222,
                    //*****************************************>>>
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });

                      try {
                        final user = await _auth.signInWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);

                        if (user != null)
                          _loggedInUser = await _auth.currentUser();
                      } catch (e) {
                        setState(() {
                          showSpinner = false;
                        });
                        setState(() {
                          ShowAlert.warning = e.message;
                        });
                      }

                      //search if loggedInUser has received feedback

                      var result = await Firestore.instance
                          .collection('feedback')
                          .where('recipient', isEqualTo: _loggedInUser.uid)
                          .getDocuments();

                      result.documents.forEach((res) {
                        if (!receivedFeedback.contains(res.data))
                          receivedFeedback.add(res.data);
                      });

                      if (receivedFeedback.isEmpty) {
                        Navigator.pushNamed(context, NoReceivedFeedback.id);
                      } else {
                        Navigator.pushNamed(
                          context,
                          ReceivedFeedback.id,
                        );
                      }

                      _emailController.clear();
                      _passwordController.clear();
                    },
                    //<<<<*****************************************
                  ),
                  TextLink(
                      text: 'Don\'t have an account? Create one ▸',
                      onTap: () {
                        Navigator.pushNamed(context, Register.id);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

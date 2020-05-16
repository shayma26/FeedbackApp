import 'package:askforfeedback/src/ui/received_feedback.dart';
import 'package:flutter/material.dart';
import 'ui/send_screen.dart';
import 'ui/registration.dart';
import 'ui/no_received_feedback.dart';
import 'ui/login.dart';

class AskForFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ask For Feedback',
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: {
        Register.id: (context) => Register(),
        LogIn.id: (context) => LogIn(),
        NoReceivedFeedback.id: (context) => NoReceivedFeedback(),
        ReceivedFeedback.id: (context) => ReceivedFeedback(),
        SendFeedback.id: (context) => SendFeedback(),
      },
      initialRoute: LogIn.id,
    );
  }
}

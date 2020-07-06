import 'package:askforfeedback/src/blocs/forgot_password_bloc_provider.dart';
import 'package:askforfeedback/src/blocs/login_bloc_provider.dart';
import 'package:askforfeedback/src/blocs/received_feedback_bloc_provider.dart';
import 'package:askforfeedback/src/blocs/register_bloc_provider.dart';
import 'package:askforfeedback/src/blocs/send_feedback_bloc_provider.dart';
import 'package:askforfeedback/src/blocs/users_bloc_provider.dart';
import 'package:askforfeedback/src/ui/received_feedback.dart';
import 'package:flutter/material.dart';
import 'ui/send_feedback.dart';
import 'ui/registration.dart';
import 'ui/no_received_feedback.dart';
import 'ui/login.dart';
import 'ui/forgot_password.dart';

class AskForFeedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterBlocProvider(
      child: LoginBlocProvider(
        child: ForgotPasswordBlocProvider(
          child: ReceivedFeedbackBlocProvider(
            child: UsersBlocProvider(
              child: FeedbackBlocProvider(
                child: MaterialApp(
                  title: 'Ask For Feedback',
                  theme: ThemeData(fontFamily: 'Poppins'),
                  routes: {
                    ForgotPassword.id: (context) => ForgotPassword(),
                    Register.id: (context) => Register(),
                    LogIn.id: (context) => LogIn(),
                    NoReceivedFeedback.id: (context) => NoReceivedFeedback(),
                    ReceivedFeedback.id: (context) => ReceivedFeedback(),
                    SendFeedback.id: (context) => SendFeedback(),
                  },
                  initialRoute: Register.id,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

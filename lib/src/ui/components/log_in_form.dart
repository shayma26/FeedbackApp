import 'package:askforfeedback/src/ui/components/text_link.dart';
import 'package:flutter/material.dart';
import '../../blocs/login_bloc_provider.dart';
import '../forgot_password.dart';
import '../no_received_feedback.dart';
import '../received_feedback.dart';
import 'custom_text_field.dart';
import 'rounded_button.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        emailField(),
        passwordField(),
        forgotPassword(),
        SizedBox(
          height: 40,
        ),
        signInButton(),
      ],
    );
  }

  Widget emailField() {
    return StreamBuilder(
        stream: _bloc.email,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return CustomTextField(
            labelName: "Email",
            onChanged: _bloc.changeEmail,
            textType: TextInputType.emailAddress,
          );
        });
  }

  Widget passwordField() {
    return StreamBuilder(
        stream: _bloc.password,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return CustomTextField(
            labelName: "Password",
            onChanged: _bloc.changePassword,
            obscure: true,
          );
        });
  }

  Widget forgotPassword() {
    return Align(
      alignment: Alignment.topRight,
      child: TextLink(
        text: 'Forgot Password',
        verticalPadding: 0.0,
        textSize: 14.0,
        onTap: () {
          Navigator.pushNamed(context, ForgotPassword.id);
        },
      ),
    );
  }

  Widget signInButton() {
    return StreamBuilder(
        stream: _bloc.progressBarStatus,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || snapshot.hasError || !snapshot.data) {
            return button();
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget button() {
    return RoundedButton(
      label: 'Login',
      labelSize: 18.0,
      width: 222,
      onPressed: () async {
        _bloc.showProgressBar(true);
        if (!await authenticateUser()) {
          showErrorMessage();
        } else
          bool b = await authenticateUser();
        _bloc.showProgressBar(false);
      },
    );
  }

  Future<bool> authenticateUser() async {
    if (!await _bloc.submit()) return false;

    _bloc.submit().then((value) async {
      if (!await _bloc.hasFeedback())
        Navigator.pushNamed(context, NoReceivedFeedback.id);
      else
        Navigator.pushNamed(context, ReceivedFeedback.id);
    });
    _bloc.isSignedIn(true);
    return true;
  }

  void showErrorMessage() {
    final snackbar = SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          "please enter valid information",
          style: TextStyle(fontSize: 17),
        ),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}

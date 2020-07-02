import 'package:askforfeedback/src/ui/no_received_feedback.dart';
import 'package:flutter/material.dart';
import '../../blocs/register_bloc_provider.dart';
import 'custom_text_field.dart';
import 'rounded_button.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  RegisterBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = RegisterBlocProvider.of(context);
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
        firstNameField(),
        lastNameField(),
        emailField(),
        passwordField(),
        SizedBox(
          height: 35,
        ),
        signUpButton(),
      ],
    );
  }

  Widget firstNameField() {
    return StreamBuilder(
        stream: _bloc.firstName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return CustomTextField(
            labelName: "First Name",
            onChanged: _bloc.changeFirstName,
          );
        });
  }

  Widget lastNameField() {
    return StreamBuilder(
        stream: _bloc.lastName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return CustomTextField(
            labelName: "Last Name",
            onChanged: _bloc.changeLastName,
          );
        });
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

  Widget signUpButton() {
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
      label: 'Sign Up',
      labelSize: 18.0,
      width: 222,
      onPressed: () async {
        if (_bloc.validateFields()) {
          authenticateUser();
        } else
          showErrorMessage(
              "please enter valid information or check password : must be more than 5 characters ");
      },
    );
  }

  void authenticateUser() async {
    _bloc.showProgressBar(true);

    if (!await _bloc.submit()) {
      showErrorMessage("account already in use or email badly formatted !");
    } else {
      await _bloc.submit().then((value) {
        Navigator.pushNamed(context, NoReceivedFeedback.id);
        _bloc.isSignedUp(true);
      });
    }
    _bloc.showProgressBar(false);
  }

  void showErrorMessage(String e) {
    final snackbar = SnackBar(
        backgroundColor: Colors.blue,
        content: Text(
          e,
          style: TextStyle(fontSize: 17),
        ),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}

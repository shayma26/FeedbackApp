import 'package:askforfeedback/src/ui/no_received_feedback.dart';
import 'package:flutter/material.dart';
import '../../blocs/register_bloc_provider.dart';
import 'custom_text_field.dart';
import 'rounded_button.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
            labelController: null,
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
            labelController: null,
            labelName: "Last Name",
            onChanged: _bloc.changeLastName,
          );
        });
  }

  Widget emailField() {
    return StreamBuilder(
        stream: _bloc.firstName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return CustomTextField(
            labelController: null,
            labelName: "Email",
            onChanged: _bloc.changeEmail,
            textType: TextInputType.emailAddress,
          );
        });
  }

  Widget passwordField() {
    return StreamBuilder(
        stream: _bloc.firstName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return CustomTextField(
            labelController: null,
            labelName: "Password",
            onChanged: _bloc.changePassword,
            obscure: true,
          );
        });
  }

  Widget signUpButton() {
    return StreamBuilder(
        stream: _bloc.signUpStatus,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || snapshot.hasError) {
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
        try {
          if (_bloc.validateFields()) {
            authenticateUser();
          }
        } catch (e) {
          showErrorMessage(e.message);
        }
      },
    );
  }

  void authenticateUser() {
    _bloc.showProgressBar(true);
    _bloc.submit().then((value) {
      Navigator.pushNamed(context, NoReceivedFeedback.id);
//       Navigator.pushReplacement(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => NoReceivedFeedback()));
    });
  }

  void showErrorMessage(String e) {
    final snackbar = SnackBar(
        backgroundColor: Colors.blue,
        content: Text(e),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}

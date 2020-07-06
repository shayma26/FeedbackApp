import 'package:flutter/cupertino.dart';

import 'forgot_password_bloc.dart';
export 'forgot_password_bloc.dart';

class ForgotPasswordBlocProvider extends InheritedWidget {
  final bloc = ForgotPasswordBloc();

  ForgotPasswordBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static ForgotPasswordBloc of(BuildContext context) {
    // ignore: deprecated_member_use
    return (context.inheritFromWidgetOfExactType(ForgotPasswordBlocProvider)
            as ForgotPasswordBlocProvider)
        .bloc;
  }
}

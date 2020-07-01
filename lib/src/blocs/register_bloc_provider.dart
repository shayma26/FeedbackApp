import 'package:flutter/material.dart';
import 'register_bloc.dart';
export 'register_bloc.dart';

class RegisterBlocProvider extends InheritedWidget {
  final bloc = RegisterBloc();

  RegisterBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static RegisterBloc of(BuildContext context) {
    // ignore: deprecated_member_use
    return (context.inheritFromWidgetOfExactType(RegisterBlocProvider)
            as RegisterBlocProvider)
        .bloc;
  }
}

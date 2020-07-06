import 'package:flutter/material.dart';
import 'users_bloc.dart';
export 'users_bloc.dart';

class UsersBlocProvider extends InheritedWidget {
  final bloc = UsersBloc();

  UsersBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static UsersBloc of(BuildContext context) {
    // ignore: deprecated_member_use
    return (context.inheritFromWidgetOfExactType(UsersBlocProvider)
            as UsersBlocProvider)
        .bloc;
  }
}

import 'package:flutter/material.dart';
import 'send_feedback_bloc.dart';
export 'send_feedback_bloc.dart';

class FeedbackBlocProvider extends InheritedWidget {
  final bloc = FeedbackBloc();

  FeedbackBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static FeedbackBloc of(BuildContext context) {
    // ignore: deprecated_member_use
    return (context.inheritFromWidgetOfExactType(FeedbackBlocProvider)
            as FeedbackBlocProvider)
        .bloc;
  }
}

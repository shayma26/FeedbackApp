import 'package:flutter/material.dart';
import 'received_feedback_bloc.dart';
export 'received_feedback_bloc.dart';

class ReceivedFeedbackBlocProvider extends InheritedWidget {
  final bloc = ReceivedFeedbackBloc();

  ReceivedFeedbackBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static ReceivedFeedbackBloc of(BuildContext context) {
    // ignore: deprecated_member_use
    return (context.inheritFromWidgetOfExactType(ReceivedFeedbackBlocProvider)
            as ReceivedFeedbackBlocProvider)
        .bloc;
  }
}

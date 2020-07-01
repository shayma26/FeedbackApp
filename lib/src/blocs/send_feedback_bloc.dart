import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

//import '../models/goal.dart';

import '../data/messages.dart';
import '../data/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class FeedbackBloc {
  final _repository = Repository();
  final _title = BehaviorSubject<String>();
  final _recipientName = BehaviorSubject<String>();
  final _details = BehaviorSubject<String>();
  final _skillName = BehaviorSubject<String>();
  final _action = BehaviorSubject<String>();
  //**************************************************
  final _showProgress = BehaviorSubject<bool>();
  final _showSnackBar = BehaviorSubject<bool>();

  Stream<String> get title => _title.stream.transform(_validateTitle);

  Stream<String> get details => _details.stream.transform(_validateDetails);

  Stream<bool> get showProgress => _showProgress.stream;
  Stream<String> get recipientName => _recipientName.stream;
  Stream<String> get skillName => _skillName.stream;
  Stream<String> get action => _action.stream;

  Function(String) get changeTitle => _title.sink.add;

  Function(String) get changeDetails => _details.sink.add;

  final _validateDetails = StreamTransformer<String, String>.fromHandlers(
      handleData: (details, sink) {
    sink.add(details);
  });

  final _validateTitle = StreamTransformer<String, String>.fromHandlers(
      handleData: (String title, sink) {
    if (RegExp(r'[@#<>":_`~;[\]\\|=+)(*&^%-]').hasMatch(title)) {
      sink.addError(StringConstant.titleValidateMessage);
    } else {
      sink.add(title);
    }
  });

  void submit() {
    _showProgress.sink.add(true);
    _repository
        .giveFeedback(
      _recipientName.toString(),
      _title.toString(),
      _skillName.toString(),
      _action.toString(),
      _details.toString(),
    )
        .then((value) {
      _showProgress.sink.add(false);
      _showSnackBar.sink.add(true);
    });
  }

  Future<QuerySnapshot> myFeedback() {
    return _repository.getFeedback();
  }

  //dispose all open sink
  void dispose() async {
    await _details.drain();
    _details.close();
    await _recipientName.drain();
    _recipientName.close();
    await _skillName.drain();
    _skillName.close();
    await _action.drain();
    _action.close();
    await _title.drain();
    _title.close();
    await _showProgress.drain();
    _showProgress.close();
    await _showSnackBar.drain();
    _showSnackBar.close();
  }

  //TODO
  //Convert map to goal list
//  List mapToList({DocumentSnapshot doc, List<DocumentSnapshot> docList}) {
//    if (docList != null) {
//      List<OtherGoal> goalList = [];
//      docList.forEach((document) {
//        String email = document.data[StringConstant.emailField];
//        Map<String, String> goals =
//            document.data[StringConstant.goalField] != null
//                ? document.data[StringConstant.goalField].cast<String, String>()
//                : null;
//        if (goals != null) {
//          goals.forEach((title, message) {
//            OtherGoal otherGoal = OtherGoal(email, title, message);
//            goalList.add(otherGoal);
//          });
//        }
//      });
//      return goalList;
//    } else {
//      Map<String, String> goals = doc.data[StringConstant.goalField] != null
//          ? doc.data[StringConstant.goalField].cast<String, String>()
//          : null;
//      List<Goal> goalList = [];
//      if (goals != null) {
//        goals.forEach((title, message) {
//          Goal goal = Goal(title, message);
//          goalList.add(goal);
//        });
//      }
//      return goalList;
//    }
//}

}

import '../data/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceivedFeedbackBloc {
  final _repository = Repository();
  final _title = BehaviorSubject<String>();
  final _skill = BehaviorSubject<String>();
  final _senderName = BehaviorSubject<String>();
  final _details = BehaviorSubject<String>();
  final _action = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>();

  Stream<String> get title => _title.stream;

  Stream<String> get senderName => _senderName.stream;

  Stream<String> get details => _details.stream;

  Stream<String> get action => _action.stream;

  Stream<bool> get showProgress => _showProgress.stream;

  Future<QuerySnapshot> myReceivedFeedback(String uid) {
    return _repository.getFeedback(uid);
  }

  void signOut() => _repository.signOut();

  //dispose all open sink
  void dispose() async {
    await _title.drain();
    _title.close();
    await _senderName.drain();
    _senderName.close();
    await _showProgress.drain();
    _showProgress.close();
    await _skill.drain();
    _skill.close();
    await _details.drain();
    _details.close();
    await _action.drain();
    _action.close();
  }
}

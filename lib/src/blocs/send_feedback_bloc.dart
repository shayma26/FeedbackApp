import 'dart:async';

import '../data/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class FeedbackBloc {
  final _repository = Repository();
  final _title = BehaviorSubject<String>();
  final _recipientName = BehaviorSubject<String>();
  final _details = BehaviorSubject<String>();
  final _skillName = BehaviorSubject<String>();
  final _action = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>();

  Stream<String> get title => _title.stream.transform(_validateTitle);
  Stream<String> get details => _details.stream.transform(_validateDetails);
  Stream<bool> get progress => _showProgress.stream;
  Stream<String> get recipientName => _recipientName.stream;
  Stream<String> get skillName => _skillName.stream;
  Stream<String> get action => _action.stream;

  String get loggedInUserUID => _repository.getLoggedInUserUID();

  Function(String) get changeTitle => _title.sink.add;
  Function(String) get changeRecipient => _recipientName.sink.add;
  Function(String) get changeSkill => _skillName.sink.add;
  Function(String) get changeAction => _action.sink.add;
  Function(String) get changeDetails => _details.sink.add;
  Function(bool) get showProgress => _showProgress.sink.add;

  final _validateDetails = StreamTransformer<String, String>.fromHandlers(
      handleData: (details, sink) {
    sink.add(details);
  });

  final _validateTitle = StreamTransformer<String, String>.fromHandlers(
      handleData: (String title, sink) {
    sink.add(title);
  });

  void signOut() => _repository.signOut();

  void giveFeedback() {
    _showProgress.sink.add(true);
    _repository
        .giveFeedback(
      recipientName: _recipientName.value,
      skill: _skillName.value,
      title: _title.value,
      action: _action.value,
      details: _details.value,
    )
        .then((value) {
      _showProgress.sink.add(false);
    });
  }

  bool validateFields() {
    if (_recipientName.value != null &&
        _recipientName.value.isNotEmpty &&
        _recipientName.value != 'Foulan Foulani' &&
        _skillName.value != null &&
        _skillName.value.isNotEmpty &&
        _skillName.value !=
            'Choose the skill you want to receive feedback on' &&
        _title.value.isNotEmpty &&
        _action.value != null &&
        _action.value.isNotEmpty &&
        _details.value != null &&
        _details.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
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
  }
}

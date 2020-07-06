import 'package:askforfeedback/src/data/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class ForgotPasswordBloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>();

  Stream<String> get email => _email.stream;

  Stream<bool> get progressBarStatus => _showProgress.stream;

  Function(String) get changeEmail => _email.sink.add;

  Function(bool) get showProgressBar => _showProgress.sink.add;

  Future<void> reset() {
    return _repository.reset(_email.value);
  }

  void dispose() async {
    await _email.drain();
    _email.close();
    await _showProgress.drain();
    _showProgress.close();
  }
}

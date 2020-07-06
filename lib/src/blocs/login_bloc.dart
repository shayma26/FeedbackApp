import '../data/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class LoginBloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isSignedIn = BehaviorSubject<bool>();
  final _showProgressBar = BehaviorSubject<bool>();

  Stream<String> get email => _email.stream;

  Stream<String> get password => _password.stream;

  Stream<bool> get signInStatus => _isSignedIn.stream;

  String get emailAddress => _email.value;

  Stream<bool> get progressBarStatus => _showProgressBar.stream;

  String get loggedInUserUID => _repository.getLoggedInUserUID();

  // Change data
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(bool) get isSignedIn => _isSignedIn.sink.add;

  Function(bool) get showProgressBar => _showProgressBar.sink.add;

  Future<bool> submit() {
    return _repository.authenticateUser(_email.value, _password.value);
  }

  Future<bool> hasFeedback() => _repository.hasFeedback();

  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
    await _isSignedIn.drain();
    _isSignedIn.close();
    await _showProgressBar.drain();
    _showProgressBar.close();
  }
}

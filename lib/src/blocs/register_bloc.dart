import '../data/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import '../data/messages.dart';

class RegisterBloc {
  final _repository = Repository();
  final _email = BehaviorSubject<String>();
  final _firstName = BehaviorSubject<String>();
  final _lastName = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _isSignedUp = BehaviorSubject<bool>();

  Stream<String> get email => _email.stream.transform(_validateEmail);

  Stream<String> get password => _password.stream.transform(_validatePassword);

  Stream<bool> get signUpStatus => _isSignedUp.stream;

  Stream<String> get firstName => _firstName.stream;

  Stream<String> get lastName => _lastName.stream;

  String get emailAddress => _email.value;

  // Change data
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Function(String) get changeFirstName => _firstName.sink.add;

  Function(String) get changeLastName => _lastName.sink.add;

  Function(bool) get showProgressBar => _isSignedUp.sink.add;

  final _validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@')) {
      sink.add(email);
    } else {
      sink.addError(StringConstant.emailValidateMessage);
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 6) {
      sink.add(password);
    } else {
      sink.addError(StringConstant.passwordValidateMessage);
    }
  });

  Future<bool> submit() {
    return _repository.registerUser(
        _firstName.value, _lastName.value, _email.value, _password.value);
  }

  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
    await _isSignedUp.drain();
    _isSignedUp.close();
    await _firstName.drain();
    _firstName.close();
    await _lastName.drain();
    _lastName.close();
  }

  bool validateFields() {
    if (_email.value != null &&
        _email.value.isNotEmpty &&
        _password.value != null &&
        _password.value.isNotEmpty &&
        _email.value.contains('@') &&
        _password.value.length > 6 &&
        _firstName.value != null &&
        _firstName.value.isNotEmpty &&
        _lastName.value != null &&
        _lastName.value.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

import 'package:askforfeedback/src/data/user.dart';

import '../data/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class UsersBloc {
  final _repository = Repository();
  final _user = BehaviorSubject<String>();

  Stream<String> get user => _user.stream;

  Function(String) get changeUser => _user.sink.add;

  Stream getUsersStream() => _repository.getUsers();

  List<User> getUsersList() {
    List<User> list = [];
    getUsersStream().listen((value) {
      list.add(User(completeName: value.toString()));
    });
    return list;
  }

  void dispose() async {
    _user.drain();
  }
}

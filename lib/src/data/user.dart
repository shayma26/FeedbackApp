import 'package:flutter/material.dart';

class User {
  User({this.completeName});
  String completeName;
}

bool isThere({List<User> list, User user}) {
  for (var item in list) {
    if (item.completeName == user.completeName) {
      return true;
    }
  }
  return false;
}

Widget getListTile({User user, Function onTap}) {
  return ListTile(
    title: Text(
      '${user.completeName}',
      style: TextStyle(fontSize: 16),
    ),
    onTap: onTap,
  );
}

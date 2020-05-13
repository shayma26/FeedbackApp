import 'package:flutter/material.dart';

class Member {
  Member({this.firstName, this.lastName});
  String firstName;
  String lastName;
}

Widget getListTile({Member member, Function onTap}) {
  return ListTile(
    title: Text(
      '${member.firstName} ${member.lastName.toUpperCase()}',
      style: TextStyle(fontSize: 18),
    ),
    onTap: onTap,
  );
}

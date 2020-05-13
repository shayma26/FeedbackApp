import 'package:flutter/material.dart';

class Member {
  Member({this.firstName, this.lastName});
  String firstName;
  String lastName;
}

bool isThere({List<Member> list, Member member}) {
  for (var item in list) {
    if (item.firstName == member.firstName &&
        item.lastName == member.lastName) {
      return true;
    }
  }
  return false;
}

Widget getListTile({Member member, Function onTap}) {
  return ListTile(
    title: Text(
      '${member.firstName} ${member.lastName}',
      style: TextStyle(fontSize: 16),
    ),
    onTap: onTap,
  );
}

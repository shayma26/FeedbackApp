import 'package:flutter/material.dart';

class Member {
  Member({this.completeName});
  String completeName;
}

bool isThere({List<Member> list, Member member}) {
  for (var item in list) {
    if (item.completeName == member.completeName) {
      return true;
    }
  }
  return false;
}

Widget getListTile({Member member, Function onTap}) {
  return ListTile(
    title: Text(
      '${member.completeName}',
      style: TextStyle(fontSize: 16),
    ),
    onTap: onTap,
  );
}

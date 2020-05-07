import 'package:flutter/material.dart';

class Member {
  Member({this.memberName, this.memberImage});
  String memberName;
  AssetImage memberImage;
}

class Team {
  Team({this.teamName, this.teamMembers, this.isExpanded = true});
  String teamName; //headerValue
  List<Member> teamMembers; //expandedValue
  bool isExpanded;
}

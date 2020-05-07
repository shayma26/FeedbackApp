import 'package:flutter/material.dart';
import 'teams_config.dart';

//******************************************************************
List<Member> members1 = [
  Member(
    memberName: 'Foulena ElFoulani',
    memberImage: AssetImage('images/myavatar.jpg'),
  ),
  Member(
    memberName: 'Foulan Ben Foulan',
    memberImage: AssetImage('images/avatar1.jpg'),
  ),
];

List<Member> members2 = [
  Member(
    memberName: 'Alleen Foulani',
    memberImage: AssetImage('images/avatar2.jpg'),
  ),
  Member(
    memberName: 'Foulan Ben Allen',
    memberImage: AssetImage('images/avatar3.jpg'),
  ),
  Member(
    memberName: 'Farid Foulani',
    memberImage: AssetImage('images/avatar4.jpg'),
  ),
  Member(
    memberName: 'Foulan Ben Farid',
    memberImage: AssetImage('images/myavatar.jpg'),
  ),
];

List<Team> teams = [
  Team(teamName: 'Team 1', teamMembers: members1),
  Team(teamName: 'Team 2', teamMembers: members2)
];
//******************************************************************

List<Member> allMembers = getAllMembers(teams);

List<Member> getAllMembers(List<Team> teams) {
  List<Member> list = [];
  for (var team in teams) {
    for (var member in team.teamMembers) {
      list.add(member);
    }
  }
  return list;
}

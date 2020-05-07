import 'package:flutter/material.dart';
import 'feedback_const.dart';
import 'package:flutter/widgets.dart';

class SkillsMenu extends StatefulWidget {
  @override
  _SkillsMenuState createState() => _SkillsMenuState();
}

class _SkillsMenuState extends State<SkillsMenu> {
  void selectItem(String name) {
    Navigator.pop(context, name);
  }

  List<String> skills = [
    'One skill',
    'Important Skill',
    'A skill with a really really really really really long name',
    'Another skill',
    'Name a skill',
    'A skill with really really really really really long name',
    'just pick one',
  ];

  Widget getButtonWidgets(List<String> strings) {
    List<Widget> list = List<Widget>();
    for (var string in strings) {
      list.add(
        CustomButton(
          fillText: string,
          onPressed: () {
            selectItem(string);
          }, //onPressed
        ), //CustomButton
      ); //add
    } //for loop
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: viewportConstraints.maxHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: list,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff737373),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffF3F2F3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Choose a skill',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: getButtonWidgets(skills)),
          ],
        ),
      ),
    );
  }
}

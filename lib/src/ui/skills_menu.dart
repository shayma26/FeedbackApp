import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'components/large_flat_button.dart';
import '../data/skillsTitlesAndActions.dart';

class SkillsMenu extends StatefulWidget {
  @override
  _SkillsMenuState createState() => _SkillsMenuState();
}

class _SkillsMenuState extends State<SkillsMenu> {
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
            Expanded(child: getButtonWidgets(Skills)),
          ],
        ),
      ),
    );
  }

  void selectItem(String name) {
    Navigator.pop(context, name);
  }

  Widget getButtonWidgets(List<String> skills) {
    List<Widget> list = List<Widget>();
    for (String skill in skills) {
      list.add(
        LargeFlatButton(
          fillText: skill,
          onPressed: () {
            selectItem(skill);
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
}

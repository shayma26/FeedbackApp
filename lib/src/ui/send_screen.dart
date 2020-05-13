import 'package:askforfeedback/src/ui/skills_menu.dart';
import 'package:flutter/material.dart';
import 'teams_menu.dart';
import '../../feedback_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/rounded_button.dart';
import '../components/important_title.dart';

enum skillAction { stop_that, keep_doing, take_action }

final _firestore = Firestore.instance;
bool showSnackBar = false;

class SendFeedback extends StatefulWidget {
  @override
  _SendFeedbackState createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  Future<String> showMenu(Widget widget, bool isScrolled) async {
    return await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        elevation: 5.0,
        isScrollControlled: isScrolled,
        context: context,
        builder: (BuildContext context) {
          return widget;
        });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  String _recipientName = 'Foulan Foulani';
  String _skillName = 'Choose the skill you want to receive feedback on';
  String _titleText;
  String _detailsText;
  skillAction _selectedAction;

  bool _validateTitle = false;
  bool _validateDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      body: Builder(builder: (context) {
        return ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ImportantTitle(
                  biggerTitle: 'Ask For Feedback',
                  bigTitle: 'New Request',
                  verticalPadding: 90,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.grey[700],
                    iconSize: 20.0,
                    padding: EdgeInsets.only(left: 15.0, bottom: 20.0),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(18.0),
                  margin: EdgeInsets.symmetric(vertical: 25.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      var name = await showMenu(TeamsMenu(), true);
                      setState(() {
                        _recipientName = name;
                      });
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Choose a recipient',
                          textAlign: TextAlign.left,
                          style: kTitleDecoration.copyWith(fontSize: 16.0),
                        ),
                        Text(
                          _recipientName,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(8.0, 13.0, 13.0, 13.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () async {
                            var name = await showMenu(SkillsMenu(), false);
                            setState(() {
                              _skillName = name;
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Skill',
                                textAlign: TextAlign.left,
                                style: kTitleDecoration,
                              ),
                              Text(
                                _skillName,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Title',
                              textAlign: TextAlign.left,
                              style: kTitleDecoration,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                decoration: kTextFieldDecoration.copyWith(
                                  errorText: _validateTitle
                                      ? 'Please write the feedback\'s title '
                                      : null,
                                ),
                                controller: titleController,
                                onChanged: (title) {
                                  setState(() {
                                    _validateTitle = false;
                                  });

                                  _titleText = title;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 23.0,
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'You should',
                                  textAlign: TextAlign.right,
                                  style: kTitleDecoration,
                                ),
                                Wrap(
                                  spacing: 6.0,
                                  children: <Widget>[
                                    ChoiceChip(
                                      label: Text(
                                        'Stop That',
                                        style: TextStyle(
                                            color: _selectedAction ==
                                                    skillAction.stop_that
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                      backgroundColor: _selectedAction ==
                                              skillAction.stop_that
                                          ? Colors.red
                                          : Colors.transparent,
                                      shape: StadiumBorder(
                                          side: BorderSide(color: Colors.red)),
                                      avatar: Icon(
                                        FontAwesomeIcons.times,
                                        color: _selectedAction ==
                                                skillAction.stop_that
                                            ? Colors.white
                                            : Colors.red,
                                      ),
                                      selected: false,
                                      onSelected: (bool selected) {
                                        _selectedAction = skillAction.stop_that;
                                        setState(() {});
                                      },
                                      selectedColor: Colors.red,
                                    ),
                                    ChoiceChip(
                                        label: Text(
                                          'Take Action',
                                          style: TextStyle(
                                              color: _selectedAction ==
                                                      skillAction.take_action
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        avatar: Icon(
                                          FontAwesomeIcons.exclamation,
                                          color: _selectedAction ==
                                                  skillAction.take_action
                                              ? Colors.white
                                              : Colors.orange,
                                        ),
                                        backgroundColor: _selectedAction ==
                                                skillAction.take_action
                                            ? Colors.orange
                                            : Colors.transparent,
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: Colors.orange)),
                                        selected: false,
                                        onSelected: (bool selected) {
                                          _selectedAction =
                                              skillAction.take_action;
                                          setState(() {});
                                        }),
                                    ChoiceChip(
                                        label: Text(
                                          'Keep Doing',
                                          style: TextStyle(
                                              color: _selectedAction ==
                                                      skillAction.keep_doing
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        avatar: Icon(
                                          FontAwesomeIcons.check,
                                          color: _selectedAction ==
                                                  skillAction.keep_doing
                                              ? Colors.white
                                              : Colors.green,
                                        ),
                                        backgroundColor: _selectedAction ==
                                                skillAction.keep_doing
                                            ? Colors.green
                                            : Colors.transparent,
                                        shape: StadiumBorder(
                                            side: BorderSide(
                                                color: Colors.green)),
                                        selected: false,
                                        onSelected: (bool selected) {
                                          _selectedAction =
                                              skillAction.keep_doing;
                                          setState(() {});
                                        }),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 23.0,
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Details',
                                  textAlign: TextAlign.left,
                                  style: kTitleDecoration,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    maxLines: 4,
                                    decoration: kTextFieldDecoration.copyWith(
                                      errorText: _validateDetails
                                          ? 'Please write the feedback\'s details '
                                          : null,
                                      hintText:
                                          'Add more details to your request',
                                      hintStyle: TextStyle(
                                        fontSize: 14.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                    ),
                                    controller: detailsController,
                                    onChanged: (details) {
                                      setState(() {
                                        _validateDetails = false;
                                      });

                                      _detailsText = details;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: RoundedButton(
                          label: 'Send',
                          onPressed: () {
                            if (titleController.text.isEmpty ||
                                detailsController.text.isEmpty ||
                                _skillName ==
                                    'Choose the skill you want to receive feedback on' ||
                                _recipientName == 'Foulan Foulani' ||
                                _recipientName.isEmpty ||
                                _skillName.isEmpty ||
                                _selectedAction == null) {
                              if (titleController.text.isEmpty)
                                setState(() {
                                  _validateTitle = true;
                                });
                              if (detailsController.text.isEmpty)
                                setState(() {
                                  _validateDetails = true;
                                });
                              if (_recipientName == 'Foulan Foulani' ||
                                  _recipientName == null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Please choose a recipient'),
                                  duration:
                                      Duration(seconds: 1, milliseconds: 30),
                                ));
                              }
                              if (_skillName ==
                                      'Choose the skill you want to receive feedback on' ||
                                  _skillName == null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Please choose a skill'),
                                  duration:
                                      Duration(seconds: 1, milliseconds: 30),
                                ));
                              }
                              if (_selectedAction == null) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Please select a skill action'),
                                  duration:
                                      Duration(seconds: 1, milliseconds: 30),
                                ));
                              }
                            } else {
                              _firestore.collection('feedback').add({
                                'recipient': _recipientName,
                                'skill': _skillName,
                                'title': _titleText,
                                'details': _detailsText,
                                'action': _selectedAction.toString(),
                                'sender': 'none',
                              });
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Row(children: <Widget>[
                                  Expanded(
                                      child:
                                          Text('Feedback sent successfully')),
                                  Icon(Icons.check)
                                ]),
                              ));

                              setState(() {
                                _validateTitle = false;

                                _recipientName = 'Foulan Foulani';
                                _skillName =
                                    'Choose the skill you want to receive feedback on';
                              });

                              titleController.clear();
                              detailsController.clear();
                              _selectedAction = null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
//
    );
  }
}

import 'package:askforfeedback/skills_menu.dart';
import 'package:flutter/material.dart';
import 'teams_menu.dart';
import 'feedback_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
bool showSnackBar = false;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  bool _validateTitle = false;
  bool _validateDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F2F3),

      body: Builder(builder: (context) {
        return ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 100.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Ask For Feedback',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'New Request',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.grey[700],
                    iconSize: 20.0,
                    padding: EdgeInsets.only(left: 15.0, bottom: 20.0),
                    onPressed: () {
                      //back to previous screen
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
                          textAlign: TextAlign.right,
                          style: kTitleDecoration.copyWith(fontSize: 16.0),
                        ),
                        Text(
                          _recipientName,
                          textAlign: TextAlign.right,
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
                                textAlign: TextAlign.right,
                                style: kTitleDecoration,
                              ),
                              Text(
                                _skillName,
                                textAlign: TextAlign.right,
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
                              textAlign: TextAlign.right,
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
                                  'Details',
                                  textAlign: TextAlign.right,
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
//
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
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: RaisedButton(
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 13.0, horizontal: 40.0),
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              onPressed: () {
                                if (titleController.text.isEmpty ||
                                    detailsController.text.isEmpty ||
                                    _skillName ==
                                        'Choose the skill you want to receive feedback on' ||
                                    _recipientName == 'Foulan Foulani' ||
                                    _recipientName.isEmpty ||
                                    _skillName.isEmpty) {
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
                                      content:
                                          Text('Please choose a recipient'),
                                      duration: Duration(
                                          seconds: 1, milliseconds: 30),
                                    ));
                                  }
                                  if (_skillName ==
                                          'Choose the skill you want to receive feedback on' ||
                                      _skillName == null) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Please choose a skill'),
                                      duration: Duration(
                                          seconds: 1, milliseconds: 30),
                                    ));
                                  }
                                } else {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Row(children: <Widget>[
                                      Expanded(
                                          child: Text(
                                              'Feedback sent successfully')),
                                      Icon(Icons.check)
                                    ]),
                                  ));
                                  setState(() {
                                    _validateTitle = false;
                                  });

                                  _firestore.collection('feedbacks').add({
                                    'recipient': _recipientName,
                                    'skill': _skillName,
                                    'title': _titleText,
                                    'details': _detailsText,
                                  });
                                  setState(() {
                                    _recipientName = 'Foulan Foulani';
                                    _skillName =
                                        'Choose the skill you want to receive feedback on';
                                  });

                                  titleController.clear();
                                  detailsController.clear();
                                }
                              }),
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

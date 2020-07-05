import 'package:askforfeedback/src/blocs/send_feedback_bloc.dart';
import 'package:askforfeedback/src/blocs/send_feedback_bloc_provider.dart';
import 'package:askforfeedback/src/ui/skills_menu.dart';
import 'package:flutter/material.dart';
import 'recipients_menu.dart';
import '../data/_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/rounded_button.dart';
import 'components/important_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class SendFeedback extends StatefulWidget {
  static String id = 'sendfeedback';

  @override
  _SendFeedbackState createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {

  FeedbackBloc _bloc;

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  String _recipientName = 'Foulan Foulani';
  String _skillName = 'Choose the skill you want to receive feedback on';
  String _titleText;
  String _detailsText;
  String _selectedAction;
  String _recipientUID;
  String _senderName;
  bool _validateTitle = false;
  bool _validateDetails = false;
  bool showSnackBar = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = FeedbackBlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      body: Builder(builder: (context) {
        //for showing snackbar
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
               actions(),
                chooseRecipient(),
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
                        child: chooseSkill(),
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            writeTitle(),

                            SizedBox(
                              height: 23.0,
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            chooseAction(),
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
                          onPressed: () async {
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
                              _bloc.giveFeedback();
//                              var searchRecipientUID = await Firestore.instance
//                                  .collection('users')
//                                  .where('complete_name',
//                                      isEqualTo: _recipientName)
//                                  .getDocuments();
//                              searchRecipientUID.documents.forEach((res) {
//                                _recipientUID = res.data['UID'];
//                              });
//
//                              var searchSenderName = await Firestore.instance
//                                  .collection('users')
//                                  .where('UID', isEqualTo: _bloc.loggedInUserUID)
//                                  .getDocuments();
//                              searchSenderName.documents.forEach((res) {
//                                _senderName = res.data['complete_name'];
//                              });
//
//                              _firestore.collection('feedback').add({
//                                'recipient': _recipientUID,
//                                'skill': _skillName,
//                                'title': _titleText,
//                                'details': _detailsText,
//                                'action': _selectedAction,
//                                'sender': _senderName,
//                              });
//                              Scaffold.of(context).showSnackBar(SnackBar(
//                                content: Row(children: <Widget>[
//                                  Expanded(
//                                      child:
//                                          Text('Feedback sent successfully')),
//                                  Icon(Icons.check)
//                                ]),
//                              ));
//
//                              setState(() {
//                                _validateTitle = false;
//
//                                _recipientName = 'Foulan Foulani';
//                                _skillName =
//                                    'Choose the skill you want to receive feedback on';
//                              });
//
//                              titleController.clear();
//                              detailsController.clear();
//                              _selectedAction = null;
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

  Widget actions(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        backButton(),
        signOutButton(),
      ],
    );
  }

  IconButton backButton(){
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      color: Colors.grey[700],
      iconSize: 20.0,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  IconButton signOutButton(){
    return IconButton(
        icon: Icon(
          FontAwesomeIcons.signOutAlt,
          color: Colors.grey[700],
          size: 20.0,
        ),
        onPressed: () {
          _bloc.signOut();
          Navigator.pushNamed(context, LogIn.id);
        });
  }

  Widget chooseRecipient(){
    return Container(
      padding: EdgeInsets.all(18.0),
      margin: EdgeInsets.symmetric(vertical: 25.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child:  GestureDetector(
        onTap: () async {
          var name = await showMenu(RecipientsMenu(), true);
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
    );
  }

  Widget chooseSkill(){
    return GestureDetector(
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
    );
  }

  Widget writeTitle(){
    return Column(
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
      ],
    );
  }

  Widget chooseAction(){
    return Column(
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
            redChip(),
            ChoiceChip(
                label: Text(
                  'Take Action',
                  style: TextStyle(
                      color: _selectedAction ==
                          "take_action"
                          ? Colors.white
                          : Colors.black),
                ),
                avatar: Icon(
                  FontAwesomeIcons.exclamation,
                  color:
                  _selectedAction == "take_action"
                      ? Colors.white
                      : Colors.orange,
                ),
                backgroundColor:
                _selectedAction == "take_action"
                    ? Colors.orange
                    : Colors.transparent,
                shape: StadiumBorder(
                    side: BorderSide(
                        color: Colors.orange)),
                selected: false,
                onSelected: (bool selected) {
                  _selectedAction = "take_action";
                  setState(() {});
                }),
            ChoiceChip(
                label: Text(
                  'Keep Doing',
                  style: TextStyle(
                      color: _selectedAction ==
                          "keep_doing"
                          ? Colors.white
                          : Colors.black),
                ),
                avatar: Icon(
                  FontAwesomeIcons.check,
                  color: _selectedAction == "keep_doing"
                      ? Colors.white
                      : Colors.green,
                ),
                backgroundColor:
                _selectedAction == "keep_doing"
                    ? Colors.green
                    : Colors.transparent,
                shape: StadiumBorder(
                    side: BorderSide(
                        color: Colors.green)),
                selected: false,
                onSelected: (bool selected) {
                  _selectedAction = "keep_doing";
                  setState(() {});
                }),
          ],
        )
      ],
    );
  }

  redChip(){
    return ChoiceChip(
      selectedColor: ,
      disabledColor: ,
      label: Text(
        'Stop That',
        style: TextStyle(
            color:
            _selectedAction == "stop_that"
                ? Colors.white
                : Colors.black),
      ),
      backgroundColor:
      _selectedAction == "stop_that"
          ? Colors.red
          : Colors.transparent,
      shape: StadiumBorder(
          side: BorderSide(color: Colors.red)),
      avatar: Icon(
        FontAwesomeIcons.times,
        color: _selectedAction == "stop_that"
            ? Colors.white
            : Colors.red,
      ),
      selected: false,
      onSelected: (bool selected) {
        _selectedAction = "stop_that";
        setState(() {});
      },
      selectedColor: Colors.red,
    );
  }

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
}

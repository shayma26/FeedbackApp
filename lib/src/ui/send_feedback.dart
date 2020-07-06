import 'package:askforfeedback/src/blocs/send_feedback_bloc.dart';
import 'package:askforfeedback/src/blocs/send_feedback_bloc_provider.dart';
import 'package:askforfeedback/src/ui/skills_menu.dart';
import 'package:flutter/material.dart';
import 'recipients_menu.dart';
import '../data/_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/rounded_button.dart';
import 'components/important_title.dart';
import 'login.dart';

class SendFeedback extends StatefulWidget {
  static String id = 'sendfeedback';

  @override
  _SendFeedbackState createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FeedbackBloc _bloc;

  TextEditingController titleController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  String _recipientName = 'Foulan Foulani';
  String _skillName = 'Choose the skill you want to receive feedback on';
  String _selectedAction;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = FeedbackBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      key: _scaffoldKey,
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
                            titleField(),
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
                            detailsField(),
                          ],
                        ),
                      ),
                      sendButton(),
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

  Widget actions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        backButton(),
        signOutButton(),
      ],
    );
  }

  IconButton backButton() {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      color: Colors.grey[700],
      iconSize: 20.0,
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }

  IconButton signOutButton() {
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

  Widget chooseRecipient() {
    return StreamBuilder(
        stream: _bloc.recipientName,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.all(18.0),
            margin: EdgeInsets.symmetric(vertical: 25.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: GestureDetector(
              onTap: () async {
                String name = await showMenu(RecipientsMenu(), true);
                _bloc.changeRecipient(name);
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
        });
  }

  Widget chooseSkill() {
    return StreamBuilder(
        stream: _bloc.skillName,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () async {
              String skill = await showMenu(SkillsMenu(), false);
              _bloc.changeSkill(skill);
              setState(() {
                _skillName = skill;
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
        });
  }

  Widget titleField() {
    return StreamBuilder(
        stream: _bloc.title,
        builder: (context, snapshot) {
          return Column(
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
                  decoration: kTextFieldDecoration,
                  keyboardType: TextInputType.text,
                  onChanged: (title) {
                    _bloc.changeTitle(title);
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget chooseAction() {
    return StreamBuilder(
        stream: _bloc.action,
        builder: (context, snapshot) {
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
                  yellowChip(),
                  greenChip(),
                ],
              )
            ],
          );
        });
  }

  ChoiceChip redChip() {
    return ChoiceChip(
      label: Text(
        'Stop That',
        style: TextStyle(
            color:
                _selectedAction == "stop_that" ? Colors.white : Colors.black),
      ),
      backgroundColor:
          _selectedAction == "stop_that" ? Colors.red : Colors.transparent,
      shape: StadiumBorder(side: BorderSide(color: Colors.red)),
      avatar: Icon(
        FontAwesomeIcons.times,
        color: _selectedAction == "stop_that" ? Colors.white : Colors.red,
      ),
      selected: false,
      onSelected: (bool selected) {
        _bloc.changeAction("stop_that");
        _selectedAction = "stop_that";
        setState(() {});
      },
    );
  }

  ChoiceChip yellowChip() {
    return ChoiceChip(
        label: Text(
          'Take Action',
          style: TextStyle(
              color: _selectedAction == "take_action"
                  ? Colors.white
                  : Colors.black),
        ),
        avatar: Icon(
          FontAwesomeIcons.exclamation,
          color:
              _selectedAction == "take_action" ? Colors.white : Colors.orange,
        ),
        backgroundColor: _selectedAction == "take_action"
            ? Colors.orange
            : Colors.transparent,
        shape: StadiumBorder(side: BorderSide(color: Colors.orange)),
        selected: false,
        onSelected: (bool selected) {
          _bloc.changeAction('take_action');
          _selectedAction = "take_action";
          setState(() {});
        });
  }

  ChoiceChip greenChip() {
    return ChoiceChip(
        label: Text(
          'Keep Doing',
          style: TextStyle(
              color: _selectedAction == "keep_doing"
                  ? Colors.white
                  : Colors.black),
        ),
        avatar: Icon(
          FontAwesomeIcons.check,
          color: _selectedAction == "keep_doing" ? Colors.white : Colors.green,
        ),
        backgroundColor:
            _selectedAction == "keep_doing" ? Colors.green : Colors.transparent,
        shape: StadiumBorder(side: BorderSide(color: Colors.green)),
        selected: false,
        onSelected: (bool selected) {
          _bloc.changeAction('keep_doing');
          _selectedAction = "keep_doing";
          setState(() {});
        });
  }

  Widget detailsField() {
    return StreamBuilder(
        stream: _bloc.details,
        builder: (context, snapshot) {
          return Column(
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
                    hintText: 'Add more details to your request',
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                  ),
                  onChanged: (details) {
                    _bloc.changeDetails(details);
                  },
                ),
              ),
            ],
          );
        });
  }

  Widget sendButton() {
    return StreamBuilder(
        stream: _bloc.progress,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData || snapshot.hasError || !snapshot.data) {
            return button();
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget button() {
    return Align(
      alignment: Alignment.bottomRight,
      child: RoundedButton(
        label: 'Send',
        onPressed: () async {
          if (!_bloc.validateFields()) {
            showErrorMessage();
          } else {
            _bloc.giveFeedback();
            showValidMessage();
            _recipientName = 'Foulan Foulani';
            _skillName = 'Choose the skill you want to receive feedback on';
            _selectedAction = null;
          }
        },
      ),
    );
  }

  void showErrorMessage() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'Please fill all fields',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue,
    ));
  }

  void showValidMessage() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: Colors.blue,
      content: Row(children: <Widget>[
        Expanded(child: Text('Feedback sent successfully')),
        Icon(Icons.check)
      ]),
    ));
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

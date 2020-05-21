import 'package:askforfeedback/src/components/rounded_button.dart';
import 'package:askforfeedback/src/ui/send_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:askforfeedback/feedback_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login.dart';

var stream;

void getStream() async {
  stream = Firestore.instance
      .collection('feedback')
      .where('recipient', isEqualTo: _loggedInUser.uid)
      .getDocuments();
}

final _auth = FirebaseAuth.instance;
FirebaseUser _loggedInUser;

List<Map<String, dynamic>> notifications = [];

class ReceivedFeedback extends StatefulWidget {
  static String id = 'receivedfeedback';
  static void signOut() {
    _auth.signOut();
  }

  @override
  _ReceivedFeedbackState createState() => _ReceivedFeedbackState();
}

class _ReceivedFeedbackState extends State<ReceivedFeedback> {
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        _loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RoundedButton(
        onPressed: () {
          Navigator.pushNamed(context, SendFeedback.id);
        },
        label: 'Give Feedback',
        width: 180.0,
        labelSize: 19.0,
        labelWeight: FontWeight.w500,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: kBackgroundColor,
            centerTitle: true,
            pinned: true,
            expandedHeight: 170,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.refresh,
                  color: Colors.grey,
                ),
                tooltip: 'Tap to refresh',
                onPressed: () {
                  setState(() {});
                },
              ),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.grey[700],
                    size: 20.0,
                  ),
                  onPressed: () {
                    _auth.signOut();
                    SendFeedback.signOut();
                    Navigator.pushNamed(context, LogIn.id);
                  }),
            ],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                'Received Feedback',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                FeedbackStream(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//**********************************

class FeedbackStream extends StatefulWidget {
  @override
  _FeedbackStreamState createState() => _FeedbackStreamState();
}

class _FeedbackStreamState extends State<FeedbackStream> {
  @override
  void initState() {
    super.initState();
    getStream();
  }

  @override
  void didUpdateWidget(FeedbackStream oldWidget) {
    super.didUpdateWidget(oldWidget);
    getStream();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return AlertDialog(
              title: Text(
                'Something went wrong !',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
              ),
              shape: CircleBorder(),
            );
          }
          final feedback = snapshot.data.documents;
          List<Widget> feedbackWidgets = [];
          for (var item in feedback) {
            String skillName = item.data['skill'];
            String title = item.data['title'];
            String sender = item.data['sender'];
            String details = item.data['details'];
            String action = item.data['action'];

            feedbackWidgets.add(
              Container(
                padding: EdgeInsets.all(5.0),
                margin: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(23)),
                child: ExpansionTile(
                  leading: 'skillAction.keep_doing' == action
                      ? Icon(
                          FontAwesomeIcons.solidCheckCircle,
                          color: Colors.green,
                          size: 37,
                        )
                      : 'skillAction.take_action' == action
                          ? Icon(
                              FontAwesomeIcons.exclamationCircle,
                              color: Colors.orange,
                              size: 37,
                            )
                          : Icon(
                              FontAwesomeIcons.solidTimesCircle,
                              color: Colors.red,
                              size: 37,
                            ),
                  title: Text(
                    skillName,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.blue),
                  ),
                  subtitle: RichText(
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: '$title\n',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      TextSpan(
                          text: sender,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          )),
                    ]),
                  ),
                  children: <Widget>[
                    Text(
                      details,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Column(
            children: feedbackWidgets,
          );
        } else {
          didUpdateWidget(FeedbackStream());
          return Column(
            children: <Widget>[
              CircularProgressIndicator(),
            ],
          );
        } //****************************
      },
    );
  }
}

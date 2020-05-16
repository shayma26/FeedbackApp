import 'package:askforfeedback/src/components/rounded_button.dart';
import 'package:askforfeedback/src/ui/send_screen.dart';
import 'package:flutter/material.dart';
import 'package:askforfeedback/feedback_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReceivedFeedback extends StatefulWidget {
  static String id = 'receivedfeedback';

  @override
  _ReceivedFeedbackState createState() => _ReceivedFeedbackState();
}

class _ReceivedFeedbackState extends State<ReceivedFeedback> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser _loggedInUser;
  List<Map<String, dynamic>> notifications = [];
  var result;

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

  void getFeedback() async {
    result = await Firestore.instance
        .collection('feedback')
        .where('recipient', isEqualTo: _loggedInUser.uid)
        .getDocuments();
    result.documents.forEach((res) {
      if (!notifications.contains(res.data)) notifications.add(res.data);
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getFeedback();
//    print(notifications);
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
            flexibleSpace: FlexibleSpaceBar(
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
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    ' Feedbacks',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23)),
                  child: ExpansionTile(
                    onExpansionChanged: (expand) {},
                    leading: Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                    title: Text('skill'),
                    subtitle: Text('title\nsender '),
                    children: <Widget>[Text('lorem kdi jry lo, jdjuhh djdd')],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:askforfeedback/src/blocs/received_feedback_bloc_provider.dart';
import 'components/received_feedback_future.dart';
import 'components/rounded_button.dart';
import 'package:askforfeedback/src/ui/send_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:askforfeedback/src/data/_constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'login.dart';

class ReceivedFeedback extends StatefulWidget {
  static String id = 'receivedfeedback';
  final loggedInUserUID;

  const ReceivedFeedback({this.loggedInUserUID});

  @override
  _ReceivedFeedbackState createState() => _ReceivedFeedbackState();
}

class _ReceivedFeedbackState extends State<ReceivedFeedback> {
  ReceivedFeedbackBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = ReceivedFeedbackBlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: giveFeedbackButton(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: kBackgroundColor,
            centerTitle: true,
            pinned: true,
            expandedHeight: 170,
            actions: <Widget>[
              refreshIcon(),
              signOutIcon(),
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
                ReceivedFeedbackFuture(
                  loggedInUserUID: widget.loggedInUserUID,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget giveFeedbackButton() {
    return RoundedButton(
      onPressed: () {
        Navigator.pushNamed(context, SendFeedback.id);
      },
      label: 'Give Feedback',
      width: 180.0,
      labelSize: 19.0,
      labelWeight: FontWeight.w500,
    );
  }

  IconButton refreshIcon() {
    return IconButton(
      icon: Icon(
        Icons.refresh,
        color: Colors.grey[700],
        size: 26,
      ),
      tooltip: 'Tap to refresh',
      onPressed: () {
        setState(() {});
      },
    );
  }

  IconButton signOutIcon() {
    return IconButton(
        icon: Icon(
          FontAwesomeIcons.signOutAlt,
          color: Colors.grey[700],
          size: 20.0,
        ),
        tooltip: 'Tap to sign-out',
        onPressed: () {
          _bloc.signOut();
          Navigator.pushNamed(context, LogIn.id);
        });
  }
}

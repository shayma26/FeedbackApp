import 'package:askforfeedback/src/blocs/received_feedback_bloc.dart';
import 'package:askforfeedback/src/blocs/received_feedback_bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReceivedFeedbackStream extends StatefulWidget {
  @override
  _ReceivedFeedbackStreamState createState() => _ReceivedFeedbackStreamState();
}

class _ReceivedFeedbackStreamState extends State<ReceivedFeedbackStream> {
  ReceivedFeedbackBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = ReceivedFeedbackBlocProvider.of(context);
  }

  @override
  void initState() {
    super.initState();
    _bloc.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _bloc.myReceivedFeedback(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Something went wrong !\nTry to reload page',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          final feedback = snapshot.data.documents;
          List<Widget> feedbackWidgets = [];
          for (var item in feedback) {
            String skillName = item.data['skill'];
            String title = item.data['title'];
            String senderName = item.data['sender'];
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
                  leading: 'keep_doing' == action
                      ? greenIcon()
                      : 'take_action' == action ? yellowIcon() : redIcon(),
                  title: Text(
                    skillName,
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.blue),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '$title\n',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: senderName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
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
          return Column(
            children: <Widget>[
              CircularProgressIndicator(),
              Text(
                'Loading...',
                style: TextStyle(fontSize: 25),
              ),
            ],
          );
        }
      },
    );
  }

  Icon greenIcon() {
    return Icon(
      FontAwesomeIcons.solidCheckCircle,
      color: Colors.green,
      size: 37,
    );
  }

  Icon yellowIcon() {
    return Icon(
      FontAwesomeIcons.exclamationCircle,
      color: Colors.orange,
      size: 37,
    );
  }

  Icon redIcon() {
    return Icon(
      FontAwesomeIcons.solidTimesCircle,
      color: Colors.red,
      size: 37,
    );
  }
}

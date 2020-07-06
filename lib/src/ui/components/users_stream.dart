import 'package:askforfeedback/src/blocs/users_bloc.dart';
import 'package:askforfeedback/src/blocs/users_bloc_provider.dart';
import 'package:askforfeedback/src/data/user.dart';
import 'package:flutter/material.dart';

class UsersStream extends StatefulWidget {
  @override
  _UsersStreamState createState() => _UsersStreamState();
}

class _UsersStreamState extends State<UsersStream> {
  UsersBloc _bloc;
  List<User> allMembers = [];
  String selectedRecipient;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = UsersBlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.getUsersStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Column(
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
                Text(
                  'No data yet',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
          );
        } else {
          final users = snapshot.data.documents;
          List<Widget> usersWidgets = [];
          for (var user in users) {
            String completeName = user.data['complete_name'];
            final member = User(
              completeName: completeName,
            );
            if (!isThere(list: allMembers, user: member))
              allMembers.add(member);
            usersWidgets.add(
              ListTile(
                title: Text(
                  completeName,
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  selectedRecipient = completeName;
                  Navigator.pop(context, selectedRecipient);
                },
              ),
            );
          }
          return Column(
            children: usersWidgets,
          );
        }
      },
    );
  }
}

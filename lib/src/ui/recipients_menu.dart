import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../member.dart';
import 'package:search_widget/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
String selectedRecipient;
List<Member> allMembers = [];

class RecipientsMenu extends StatefulWidget {
  @override
  _RecipientsMenuState createState() => _RecipientsMenuState();
}

class _RecipientsMenuState extends State<RecipientsMenu> {
  TextEditingController searchController = TextEditingController();

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
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 18.0),
              child: Text(
                'Choose a recipent',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: SearchWidget(
                selectedItemBuilder: null,
                hideSearchBoxWhenItemSelected: true,
                dataList: allMembers,
                listContainerHeight: MediaQuery.of(context).size.height / 4,
                queryBuilder: (query, list) {
                  return list
                      .where((item) => '${item.firstName} ${item.lastName}'
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                },
                popupListItemBuilder: (item) {
                  return PopupListItemWidget(item);
                },
              ),
            ),
            UsersStream(),
          ],
        ),
      ),
    );
  }
}

class UsersStream extends StatelessWidget {
  UsersStream({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }
        final users = snapshot.data.documents;
        List<Widget> usersWidgets = [];
        for (var user in users) {
          String firstName = user.data['first_name'];
          String lastName = user.data['last_name'];
          final member = Member(
            firstName: firstName,
            lastName: lastName,
          );
          if (!isThere(list: allMembers, member: member))
            allMembers.add(
              Member(
                firstName: firstName,
                lastName: lastName,
              ),
            );
          usersWidgets.add(
            ListTile(
              title: Text(
                '$firstName $lastName',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                selectedRecipient = ('$firstName $lastName');
                Navigator.pop(context, selectedRecipient);
              },
            ),
          );
        }
        return Column(
          children: usersWidgets,
        );
      },
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.member);

  final Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: getListTile(
        member: member,
        onTap: () {
          selectedRecipient = '${member.firstName} ${member.lastName}';
          Navigator.pop(context, selectedRecipient);
        },
      ),
    );
  }
}

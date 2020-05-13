import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../member.dart';
import 'package:search_widget/search_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
String selectedRecipient;
List<Member> allMembers = [];

void getMembers() async {
  final members = await _firestore.collection('users').getDocuments();
  for (var member in members.documents) {
    //TODO
    print(
        'first name: ${member.data['first_name']}  last name: ${member.data['last_name']}');
    allMembers.add(
      Member(
        firstName: member.data['first_name'],
        lastName: member.data['last_name'],
      ),
    );
  }
}

class TeamsMenu extends StatefulWidget {
  @override
  _TeamsMenuState createState() => _TeamsMenuState();
}

class _TeamsMenuState extends State<TeamsMenu> {
  TextEditingController searchController = TextEditingController();

  Widget getListTiles(List<Member> members) {
    List<Widget> list = List<Widget>();
    for (var member in members) {
      list.add(
        getListTile(
          member: member,
          onTap: () {
            selectedRecipient = '${member.firstName} ${member.lastName}';
            Navigator.pop(context, selectedRecipient);
          },
        ),
      );
    }
    return Column(
      children: list,
    );
  }

  @override
  void initState() {
    super.initState();
    getMembers();
  }

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
            Container(
              child: getListTiles(allMembers),
            ),
          ],
        ),
      ),
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

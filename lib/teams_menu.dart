import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'teams_config.dart';
import 'package:search_widget/search_widget.dart';
import 'teams_brain.dart';

String selectedRecipient;

class TeamsMenu extends StatefulWidget {
  @override
  _TeamsMenuState createState() => _TeamsMenuState();
}

class _TeamsMenuState extends State<TeamsMenu> {
  TextEditingController searchController = TextEditingController();

  Widget getListTiles(List<Member> members) {
    List<Widget> list = List<Widget>();
    for (var member in members) {
      list.add(ListTile(
        title: Text(member.memberName),
        leading: CircleAvatar(
          backgroundImage: member.memberImage,
        ),
        onTap: () {
          selectedRecipient = member.memberName;
          Navigator.pop(context, selectedRecipient);
        },
      ));
    }
    return Column(
      children: list,
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          teams[index].isExpanded = !isExpanded;
        });
      },
      children: teams.map<ExpansionPanel>(
        (Team team) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(team.teamName),
              );
            },
            body: getListTiles(team.teamMembers),
            isExpanded: team.isExpanded,
          );
        },
      ).toList(),
    );
  }

  List<Member> allMembers = getAllMembers(teams);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff737373),
      //    child: DraggableScrollableSheet(builder: (context, scrollController) {}
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffF3F2F3),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Choose a recipent',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
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
                      .where((item) => item.memberName
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                },
                popupListItemBuilder: (item) {
                  return PopupListItemWidget(item);
                },
                textFieldBuilder: (controller, focusNode) {
                  return MyTextField(controller, focusNode);
                },
                onItemSelected: (item) {
                  setState(() {
                    selectedRecipient = item;
                  });
                },
              ),
            ),
            Container(
              child: _buildPanel(),
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
      padding: EdgeInsets.all(12),
      child: ListTile(
        title: Text(member.memberName),
        leading: CircleAvatar(
          backgroundImage: member.memberImage,
        ),
        onTap: () {
          selectedRecipient = member.memberName;
          Navigator.pop(context, selectedRecipient);
        },
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField(this.controller, this.focusNode);

  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x4437474F),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
          ),
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          hintText: "Search a recipient",
          contentPadding: const EdgeInsets.only(
            left: 16,
            right: 20,
            top: 14,
            bottom: 14,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:askforfeedback/src/data/_constants.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {@required this.labelController,
      @required this.labelName,
      this.onChanged,
      this.obscure = false,
      this.textType = TextInputType.text});

  final TextEditingController labelController;
  final String labelName;
  final bool obscure;
  final TextInputType textType;
  final Function onChanged;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool selected = false;
  FocusNode node = FocusNode();

  @override
  void initState() {
    super.initState();
    node.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0, left: 20),
            child: Text(
              widget.labelName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: selected ? Colors.blue : Colors.black,
              ),
            ),
          ),
          Container(
            height: 35,
            child: TextField(
              onChanged: widget.onChanged,
              obscureText: widget.obscure,
              keyboardType: widget.textType,
              decoration: kTextFieldDecoration,
              controller: widget.labelController,
              focusNode: node,
            ),
          ),
        ],
      ),
    );
  }
}

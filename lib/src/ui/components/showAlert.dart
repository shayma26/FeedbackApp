import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ShowAlert extends StatefulWidget {
  static var warning;

  @override
  _ShowAlertState createState() => _ShowAlertState();
}

class _ShowAlertState extends State<ShowAlert> {
  @override
  Widget build(BuildContext context) {
    if (ShowAlert.warning != null) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 13.0),
        color: Colors.blue,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 30.0,
              ),
            ),
            Expanded(
              child: AutoSizeText(
                ShowAlert.warning,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
                maxLines: 4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    ShowAlert.warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}

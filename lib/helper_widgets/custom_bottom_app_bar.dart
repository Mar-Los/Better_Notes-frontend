import 'package:flutter/material.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';

class CustomBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Theme.of(context).colorScheme.myDarkGrey,
      notchMargin: 2.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
          SizedBox(
            width: 0.1,
          ),
          IconButton(
            icon: Icon(Icons.home, color: Colors.white),
            onPressed: () => Navigator.popUntil(
                context, (Route<dynamic> route) => route.isFirst),
          )
        ],
      ),
    );
  }
}

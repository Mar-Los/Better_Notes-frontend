import 'package:flutter/material.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';

class RowTextColumns extends StatelessWidget {
  final String keyText;
  final String valueText;
  final TextEditingController keyController;
  final TextEditingController valueController;
  final bool isEdited;

  RowTextColumns({
    Key key,
    @required this.keyText,
    @required this.valueText,
    @required this.keyController,
    @required this.valueController,
    @required this.isEdited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          Expanded(
            child: isEdited
                ? TextField(
                    controller: keyController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  )
                : Text(
                    keyText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
          ),
          VerticalDivider(
            color: Theme.of(context).colorScheme.myLightGrey,
            thickness: 0.6,
          ),
          Expanded(
            child: isEdited
                ? TextField(
                    controller: valueController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  )
                : Text(
                    valueText,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0),
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';

class RowEditOptions extends StatelessWidget {
  final Function() onCancel;
  final Function() onUpdate;

  RowEditOptions({Key key, @required this.onCancel, @required this.onUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton.icon(
              label: Text('Cancel',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  )),
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => onCancel(),
            ),
          ),
          VerticalDivider(
            color: Theme.of(context).colorScheme.myLightGrey,
            thickness: 0.6,
          ),
          Expanded(
            child: FlatButton.icon(
              label: Text('Save',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  )),
              icon: Icon(
                Icons.done,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => onUpdate(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final DialogAction action = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.yes),
                child: Text('Delete'),
              )
            ],
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<String> textFieldDialog(
    BuildContext context,
    String title,
    String labelText, {
    String inputText = '',
  }) async {
    TextEditingController _textFieldController = TextEditingController();
    _textFieldController.text = inputText;

    final String input = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: _textFieldController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(''),
              child: Text(
                'Cancel',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.myDarkGrey),
              ),
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).pop(_textFieldController.text),
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    return input;
  }
}

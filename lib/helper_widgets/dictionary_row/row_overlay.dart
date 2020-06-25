import 'package:flutter/material.dart';

class RowOverlay extends StatelessWidget {
  final Function() onDelete;
  final Function() onEdit;

  RowOverlay({Key key, @required this.onDelete, @required this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[50].withOpacity(0.93),
      child: Row(
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => onEdit(),
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => onDelete(),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cloud_note_app/custom_color_scheme.dart';
import 'package:flutter/material.dart';

class NewRow extends StatelessWidget {
  final TextEditingController keyController;
  final TextEditingController valueController;
  final void Function() onChanged;
  final FocusNode keyFieldFocusNode;

  NewRow({
    Key key,
    @required this.keyController,
    @required this.valueController,
    @required this.onChanged,
    @required this.keyFieldFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: keyController,
              focusNode: keyFieldFocusNode,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add new key',
              ),
              onChanged: (value) => onChanged(),
            ),
          ),
          VerticalDivider(
            color: Theme.of(context).colorScheme.myLightGrey,
            thickness: 0.6,
          ),
          Expanded(
            child: TextField(
              controller: valueController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Add new value',
              ),
              onChanged: (value) => onChanged(),
            ),
          ),
        ],
      ),
    );
  }
}

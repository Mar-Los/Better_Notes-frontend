import 'package:cloud_note_app/helper_widgets/dictionary_row/row_overlay.dart';
import 'package:cloud_note_app/helper_widgets/dictionary_row/row_edit_options.dart';
import 'package:cloud_note_app/helper_widgets/dictionary_row/row_text_columns.dart';
import 'package:flutter/material.dart';

class DictionaryRow extends StatefulWidget {
  final String keyColumn;
  final String valueColumn;
  final Function() onDelete;
  final Function(String keyColumn, String valueColumn) onUpdate;

  DictionaryRow({
    Key key,
    @required this.keyColumn,
    @required this.valueColumn,
    @required this.onDelete,
    @required this.onUpdate,
  }) : super(key: key);

  @override
  _DictionaryRowState createState() => _DictionaryRowState();
}

class _DictionaryRowState extends State<DictionaryRow> {
  final TextEditingController _keyController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  bool isOverlay = false;
  bool isEdited = false;

  Future<void> _updateRow() async {
    String key = _keyController.text;
    String value = _valueController.text;

    await widget.onUpdate(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (!isEdited) setState(() => isOverlay = !isOverlay);
      },
      focusColor: Colors.grey[50],
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              RowTextColumns(
                isEdited: isEdited,
                keyController: _keyController,
                valueController: _valueController,
                keyText: widget.keyColumn,
                valueText: widget.valueColumn,
              ),
              if (isEdited) ...[
                RowEditOptions(
                  onCancel: () => setState(() => isEdited = false),
                  onUpdate: () async {
                    if (_valueController.text != '' ||
                        _keyController.text != '') await _updateRow();
                    setState(() => isEdited = false);
                  },
                ),
              ]
            ],
          ),
          if (isOverlay) ...[
            RowOverlay(
              onEdit: () {
                setState(() {
                  isEdited = true;
                  isOverlay = false;
                });
                _keyController.text = widget.keyColumn;
                _valueController.text = widget.valueColumn;
              },
              onDelete: () {
                widget.onDelete();
                isOverlay = false;
              },
            )
          ],
        ],
      ),
    );
  }
}

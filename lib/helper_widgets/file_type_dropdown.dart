import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';

import 'package:cloud_note_app/utils/file_object_params.dart';

class FileTypeDropdown extends StatelessWidget {
  FileTypeDropdown(
      {Key key, @required this.chosenType, @required this.onTypeChanged})
      : super(key: key);

  final ValueChanged<FileType> onTypeChanged;
  final FileType chosenType;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      items: FileType.values.map<DropdownMenuItem<String>>((FileType fileType) {
        String dropDownHeader =
            '${describeEnum(fileType)[0].toUpperCase()}${describeEnum(fileType).substring(1)}';
        return DropdownMenuItem<String>(
          value: describeEnum(fileType),
          child: Text(dropDownHeader),
        );
      }).toList(),
      value: describeEnum(chosenType),
      onChanged: (value) {
        final FileType fileTypeEnum = getFileTypeFromString(value);
        onTypeChanged(fileTypeEnum);
      },
      style: TextStyle(
        color: Theme.of(context).colorScheme.myDarkGrey,
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(FILE_ICONS[chosenType]),
        labelText: 'Type',
        border: OutlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 10.0,
        ),
      ),
      iconSize: 30.0,
      isExpanded: true,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';

import 'package:cloud_note_app/utils/file_object_params.dart';

class FileObjectChoice extends StatelessWidget {
  FileObjectChoice({
    Key key,
    @required this.fileObjectType,
    @required this.active,
    @required this.onChanged,
  }) : super(key: key);

  final ValueChanged<FileObjectType> onChanged;
  final FileObjectType fileObjectType;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(fileObjectType);
      },
      child: Container(
        height: 175.0,
        width: 160.0,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey[200],
              offset: Offset(3, 5),
              blurRadius: 10.0,
              spreadRadius: 5.0,
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              fileObjectType == FileObjectType.folder ? 'Folder' : 'File',
              style: TextStyle(
                color: active
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.myLightGrey,
                fontSize: 30.0,
                fontWeight: active ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            Icon(
              fileObjectType == FileObjectType.folder
                  ? Icons.folder
                  : Icons.assignment,
              size: active ? 110.0 : 90.0,
              color: active
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.myLightGrey,
            ),
          ],
        ),
      ),
    );
  }
}

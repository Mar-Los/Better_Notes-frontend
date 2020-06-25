import 'package:cloud_note_app/helper_widgets/connection_sensitive.dart';
import 'package:cloud_note_app/helper_widgets/custom_bottom_app_bar.dart';
import 'package:cloud_note_app/utils/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_note_app/controllers/file_controller.dart';
import 'package:cloud_note_app/controllers/folder_controller.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';
import 'package:cloud_note_app/helper_widgets/file_type_dropdown.dart';
import 'package:cloud_note_app/helper_widgets/file_object_choice.dart';

import 'package:cloud_note_app/utils/file_object_params.dart';

class CreatePage extends StatefulWidget {
  final dynamic parentId;
  CreatePage({Key key, @required this.parentId}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final FolderController _folderController = FolderController();
  final FileController _fileController = FileController();

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  FileObjectType _chosenFileObject = FileObjectType.folder;
  FileType _chosenFileType = FileType.text;

  void _submit() async {
    String name = _nameController.text;
    String jwt = Provider.of<UserModel>(context, listen: false).jwt;

    if (_chosenFileObject == FileObjectType.folder) {
      await _folderController.createFolder(jwt, widget.parentId, name);
    } else if (_chosenFileObject == FileObjectType.file) {
      await _fileController.createFile(
          jwt, widget.parentId, name, describeEnum(_chosenFileType));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ConnectionSensitive(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Create File or Folder'),
        ),
        bottomNavigationBar: CustomBottomAppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FileObjectChoice(
                        fileObjectType: FileObjectType.folder,
                        active: _chosenFileObject == FileObjectType.folder,
                        onChanged: (thisFileObject) {
                          setState(() {
                            _chosenFileObject = thisFileObject;
                          });
                        }),
                    Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).colorScheme.myLightGrey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FileObjectChoice(
                      fileObjectType: FileObjectType.file,
                      active: _chosenFileObject == FileObjectType.file,
                      onChanged: (thisFileObject) {
                        setState(() {
                          _chosenFileObject = thisFileObject;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 60.0,
                ),
                if (_chosenFileObject == FileObjectType.file) ...[
                  FileTypeDropdown(
                    chosenType: _chosenFileType,
                    onTypeChanged: (FileType newType) {
                      setState(() {
                        _chosenFileType = newType;
                      });
                    },
                  ),
                  SizedBox(
                    height: 35.0,
                  )
                ],
                TextFormField(
                  controller: _nameController,
                  maxLength: 50,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "This field is required.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.title),
                  ),
                ),
                SizedBox(height: 15.0),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _submit();
                    }
                  },
                  child: Text(
                    'Create',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 5.0,
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

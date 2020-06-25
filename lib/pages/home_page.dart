import 'package:cloud_note_app/controllers/folder_controller.dart';
import 'package:cloud_note_app/helper_widgets/connection_sensitive.dart';
import 'package:cloud_note_app/helper_widgets/custom_bottom_app_bar.dart';
import 'package:cloud_note_app/utils/dialogs.dart';
import 'package:cloud_note_app/helper_widgets/file_object_builder.dart';
import 'package:cloud_note_app/utils/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FolderController folderController = FolderController();

  Future<List> _foldersFuture;
  String _jwt;

  @override
  void didChangeDependencies() {
    _jwt = Provider.of<UserModel>(context, listen: false).jwt;
    _foldersFuture = folderController.getRootFolders(_jwt);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectionSensitive(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.home,
              ),
              SizedBox(width: 7.0),
              Text('Home')
            ],
          ),
          centerTitle: true,
        ),
        body: FileObjectList(
          fileObjectsFuture: _foldersFuture,
          jwt: _jwt,
          fileObjectsChanged: () {
            setState(() {
              _foldersFuture = folderController.getRootFolders(_jwt);
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final String folderName = await Dialogs.textFieldDialog(
                context, 'Create New Folder', 'Folder Name');
            if (folderName != '') {
              folderController.createRootFolder(_jwt, folderName).then((_) {
                setState(() {
                  _foldersFuture = folderController.getRootFolders(_jwt);
                });
              });
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CustomBottomAppBar(),
      ),
    );
  }
}

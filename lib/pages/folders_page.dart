import 'package:cloud_note_app/controllers/file_object_controller.dart';
import 'package:cloud_note_app/helper_widgets/connection_sensitive.dart';
import 'package:cloud_note_app/helper_widgets/custom_bottom_app_bar.dart';
import 'package:cloud_note_app/helper_widgets/file_object_builder.dart';
import 'package:cloud_note_app/utils/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoldersPage extends StatefulWidget {
  final int parentId;
  final String parentName;
  FoldersPage({Key key, @required this.parentId, @required this.parentName})
      : super(key: key);

  @override
  _FoldersPageState createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  final FileObjectController _fileObjectController = FileObjectController();

  String _jwt;

  Future<List> _fileObjectsFuture;

  Future<List> _filteredFileObjectsFuture;
  bool isSearching = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _jwt = Provider.of<UserModel>(context, listen: false).jwt;
    _fileObjectsFuture = _filteredFileObjectsFuture =
        _fileObjectController.getFileObjectsOfFolder(_jwt, widget.parentId);
  }

  void _filterFileObjects(value) async {
    Future<List> filteredFileObjects = _fileObjectsFuture.then((fileObjects) {
      return fileObjects
          .where((fileObject) =>
              fileObject['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
    setState(() {
      _filteredFileObjectsFuture = filteredFileObjects;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConnectionSensitive(
      child: Scaffold(
        appBar: AppBar(
          title: isSearching
              ? TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  onChanged: _filterFileObjects,
                )
              : Text(widget.parentName),
          actions: <Widget>[
            IconButton(
              icon: isSearching ? Icon(Icons.close) : Icon(Icons.search),
              onPressed: () {
                setState(() {
                  if (isSearching)
                    _filteredFileObjectsFuture = _fileObjectsFuture;
                  isSearching = !isSearching;
                });
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: FileObjectList(
                fileObjectsFuture: _filteredFileObjectsFuture,
                jwt: _jwt,
                fileObjectsChanged: () {
                  setState(() {
                    _fileObjectsFuture = _filteredFileObjectsFuture =
                        _fileObjectController.getFileObjectsOfFolder(
                            _jwt, widget.parentId);
                  });
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (isSearching) {
              _filteredFileObjectsFuture = _fileObjectsFuture;
              isSearching = false;
            }
            Navigator.pushNamed(context, '/create', arguments: widget.parentId)
                .then((_) {
              setState(() {
                _filteredFileObjectsFuture = _fileObjectsFuture =
                    _fileObjectController.getFileObjectsOfFolder(
                        _jwt, widget.parentId);
              });
            });
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

import 'package:cloud_note_app/controllers/file_controller.dart';
import 'package:cloud_note_app/controllers/folder_controller.dart';
import 'package:cloud_note_app/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:cloud_note_app/folder_arguments.dart';
import 'package:cloud_note_app/custom_color_scheme.dart';
import 'package:cloud_note_app/utils/file_object_params.dart';

class FileObjectList extends StatelessWidget {
  final Future<List> fileObjectsFuture;
  final String jwt;
  final void Function() fileObjectsChanged;
  final FolderController _folderController = FolderController();
  final FileController _fileController = FileController();

  FileObjectList(
      {@required this.fileObjectsFuture,
      @required this.jwt,
      @required this.fileObjectsChanged});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fileObjectsFuture,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(child: CircularProgressIndicator());

        List fileObjects = snapshot.data;

        return ListView.builder(
          shrinkWrap: true,
          itemCount: fileObjects == null ? 0 : fileObjects.length,
          itemBuilder: (BuildContext context, int index) {
            bool isFolder = !fileObjects[index].containsKey('type');

            return ListTile(
              title: Text(
                fileObjects[index]['name'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              leading: Icon(
                isFolder
                    ? Icons.folder
                    : FILE_ICONS[
                        getFileTypeFromString(fileObjects[index]['type'])],
                color: Theme.of(context).colorScheme.myDarkGrey,
              ),
              trailing: PopupMenuButton<String>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'rename',
                    child: Text('Rename'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  ),
                ],
                icon: Icon(Icons.more_vert),
                onSelected: (value) async {
                  switch (value) {
                    case 'rename':
                      if (isFolder) {
                        final String name = await Dialogs.textFieldDialog(
                          context,
                          'Rename Folder',
                          'Folder name',
                          inputText: fileObjects[index]['name'],
                        );
                        if (name != '') {
                          await _folderController.updateFolder(
                              jwt, fileObjects[index]['id'],
                              name: name);
                          fileObjectsChanged();
                        }
                      } else {
                        final String name = await Dialogs.textFieldDialog(
                          context,
                          'Rename File',
                          'File name',
                          inputText: fileObjects[index]['name'],
                        );
                        if (name != '') {
                          await _fileController.updateFile(
                              jwt, fileObjects[index]['id'],
                              name: name);
                          fileObjectsChanged();
                        }
                      }
                      break;
                    case 'delete':
                      if (isFolder) {
                        final action = await Dialogs.yesAbortDialog(
                          context,
                          'Are you sure you want to delete "${fileObjects[index]['name']}" and its contents?',
                          'This action is irreversible.',
                        );
                        if (action == DialogAction.yes) {
                          await _folderController.deleteFolder(
                              jwt, fileObjects[index]['id']);
                          fileObjectsChanged();
                        }
                      } else {
                        final action = await Dialogs.yesAbortDialog(
                          context,
                          'Are you sure you want to delete "${fileObjects[index]['name']}" and its contents?',
                          'This action is irreversible.',
                        );
                        if (action == DialogAction.yes) {
                          await _fileController.deleteFile(
                              jwt, fileObjects[index]['id']);
                          fileObjectsChanged();
                        }
                      }
                      break;
                  }
                },
              ),
              onTap: () {
                isFolder
                    ? Navigator.pushNamed(context, '/folders',
                        arguments: FolderArguments(
                          parentId: fileObjects[index]['id'],
                          parentName: fileObjects[index]['name'],
                        ))
                    : Navigator.pushNamed(
                        context, '/${fileObjects[index]['type']}',
                        arguments: fileObjects[index]);
              },
            );
          },
        );
      },
    );
  }
}

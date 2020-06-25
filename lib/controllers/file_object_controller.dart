import 'package:cloud_note_app/controllers/file_controller.dart';
import 'package:cloud_note_app/controllers/folder_controller.dart';

class FileObjectController {
  FileController _fileController = FileController();
  FolderController _folderController = FolderController();

  Future<List> getFileObjectsOfFolder(jwt, parentId) async {
    List folders = await _folderController.getChildrenOfFolder(jwt, parentId);
    List files = await _fileController.getFolderFiles(jwt, parentId);
    List fileObjects = combineFileObjects(files, folders);
    return fileObjects;
  }

  List combineFileObjects(List files, List folders) {
    folders.sort(
        (a, b) => a['name'].toLowerCase().compareTo(b['name'].toLowerCase()));
    files.sort(
        (a, b) => a['name'].toLowerCase().compareTo(b['name'].toLowerCase()));
    List fileObjects = folders + files;
    return fileObjects;
  }
}

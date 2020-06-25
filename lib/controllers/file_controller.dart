import 'package:cloud_note_app/utils/rest_client.dart';

class FileController {
  final RestClient restClient = RestClient();
  static const FILE_URL = '/files';

  Future<List> getAllFiles(String jwt) async {
    return await restClient
        .get(FILE_URL, headers: {'Authorization': 'Bearer $jwt'});
  }

  Future<List> getFolderFiles(String jwt, int folderId) async {
    return await restClient.get('/folderfiles/$folderId',
        headers: {'Authorization': 'Bearer $jwt'});
  }

  Future<Map> getFile(String jwt, int fileId) async {
    return await restClient
        .get('$FILE_URL/$fileId', headers: {'Authorization': 'Bearer $jwt'});
  }

  Future<Map> createFile(
      String jwt, int folderId, String name, String type) async {
    return await restClient.post(FILE_URL, headers: {
      'Authorization': 'Bearer $jwt'
    }, body: {
      'folder_id': folderId.toString(),
      'name': name,
      'type': type,
    });
  }

  Future<Map> updateFile(
    String jwt,
    int fileId, {
    int folderId,
    String name,
  }) async {
    return await restClient.put('$FILE_URL/$fileId', headers: {
      'Authorization': 'Bearer $jwt'
    }, body: {
      'name': name,
      'folder_id': folderId.toString(),
    });
  }

  Future<Map> deleteFile(String jwt, int fileId) async {
    return await restClient
        .delete('$FILE_URL/$fileId', headers: {'Authorization': 'Bearer $jwt'});
  }
}

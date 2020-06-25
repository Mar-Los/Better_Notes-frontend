import 'package:cloud_note_app/utils/rest_client.dart';

class FolderController {
  final RestClient restClient = RestClient();
  static const FOLDER_URL = '/folders';

  // Future<List> getAllFolders(String jwt) async {
  //   return await restClient.get(FOLDER_URL,
  //       headers: {'Authorization': 'Bearer $jwt'}).then((dynamic res) {
  //     return res;
  //   });
  // }
  Future<List> getRootFolders(String jwt) async {
    return await restClient
        .get('$FOLDER_URL/root', headers: {'Authorization': 'Bearer $jwt'});
  }

  Future<List> getChildrenOfFolder(String jwt, int parentId) async {
    return await restClient.get('$FOLDER_URL/$parentId',
        headers: {'Authorization': 'Bearer $jwt'});
  }

  Future<Map<String, dynamic>> createRootFolder(String jwt, String name) async {
    return await restClient.post('$FOLDER_URL/root',
        headers: {'Authorization': 'Bearer $jwt'}, body: {'name': name});
  }

  Future<Map<String, dynamic>> createFolder(
      String jwt, int parentId, String name) async {
    return await restClient.post(FOLDER_URL,
        headers: {'Authorization': 'Bearer $jwt'},
        body: {'parent_id': parentId.toString(), 'name': name});
  }

  Future<Map<String, dynamic>> updateFolder(String jwt, int folderId,
      {String name = '', int parentId}) async {
    return await restClient.put('$FOLDER_URL/$folderId', headers: {
      'Authorization': 'Bearer $jwt'
    }, body: {
      'name': name,
      'parent_id': (parentId == null) ? '' : parentId.toString(),
    });
  }

  Future<Map<String, dynamic>> deleteFolder(String jwt, int folderId) async {
    return await restClient.delete(
      '$FOLDER_URL/$folderId',
      headers: {'Authorization': 'Bearer $jwt'},
    );
  }
}

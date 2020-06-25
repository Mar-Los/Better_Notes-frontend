import 'package:cloud_note_app/controllers/api_controller.dart';

class DictionaryFileController extends ApiController {
  static const DICT_FILE_URL = '/dictionaryfiles';

  DictionaryFileController(String jwt) : super(jwt);

  Future<Map> createRow(int fileId, String key, String value) async {
    return await restClient
        .post('$DICT_FILE_URL/$fileId', headers: authHeader, body: {
      'key': key,
      'value': value,
    });
  }

  Future<Map> updateRow(int fileId, int rowId,
      {String key = '', String value = ''}) async {
    return await restClient
        .put('$DICT_FILE_URL/$fileId/$rowId', headers: authHeader, body: {
      'key': key,
      'value': value,
    });
  }

  Future<Map> deleteRow(int fileId, int rowId) async {
    return await restClient.delete('$DICT_FILE_URL/$fileId/$rowId',
        headers: authHeader);
  }
}

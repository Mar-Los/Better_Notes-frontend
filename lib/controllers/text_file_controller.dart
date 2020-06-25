import 'package:cloud_note_app/utils/rest_client.dart';

class TextFileController {
  final RestClient restClient = RestClient();
  static const TEXT_FILE_URL = '/textfiles';

  Future<Map> updateTextFileContent(
      String jwt, int fileId, String content) async {
    return await restClient.put('$TEXT_FILE_URL/$fileId',
        headers: {'Authorization': 'Bearer $jwt'}, body: {'content': content});
  }
}

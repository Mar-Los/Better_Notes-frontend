import 'package:cloud_note_app/utils/rest_client.dart';

class ApiController {
  final RestClient restClient = RestClient();
  Map<String, String> authHeader;

  ApiController(String jwt) {
    authHeader = {'Authorization': 'Bearer $jwt'};
  }
}

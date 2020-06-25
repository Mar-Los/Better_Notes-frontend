import 'package:cloud_note_app/utils/rest_client.dart';

class UserController {
  RestClient restClient = RestClient();
  static const LOGIN_URL = '/login';
  static const USER_URL = '/user';
  static const REGISTER_URL = '/register';

  Future<String> login(String email, String password) async {
    return await restClient.post(LOGIN_URL, body: {
      'email': email,
      'password': password,
    }).then((dynamic res) {
      if (res.containsKey('error')) return null;
      return res['token'];
    });
  }

  Future<Map> register(String email, String password) async {
    return await restClient.post(REGISTER_URL, body: {
      'email': email,
      'password': password,
    });
  }

  Future<Map> getUser(String jwt) async {
    return await restClient
        .get(USER_URL, headers: {'Authorization': 'Bearer $jwt'});
  }
}

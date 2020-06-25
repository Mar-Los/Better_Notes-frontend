import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  int _id;
  String _jwt;
  String _email;

  String get jwt => _jwt;
  Map get userMap => {
        'id': _id,
        'email': _email,
        'jwt': _jwt,
      };

  void initialize(id, jwt, email) {
    _id = id;
    _jwt = jwt;
    _email = email;
    notifyListeners();
  }
}

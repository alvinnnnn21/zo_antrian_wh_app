import 'package:flutter/material.dart';
import 'package:sutindo_supir_app/models/user_model.dart';
import 'package:sutindo_supir_app/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  User _user = User();

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  Future<dynamic> Login(
      {required String username, required String password}) async {
    try {
      User user =
          await AuthService().Login(username: username, password: password);
      _user = user;

      notifyListeners();

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception:", "");
    }
  }
}

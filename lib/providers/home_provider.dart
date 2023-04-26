// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sutindo_supir_app/models/home_model.dart';
import 'package:sutindo_supir_app/services/home_service.dart';

class HomeProvider with ChangeNotifier {
  Home _home = Home();

  Home get home => _home;

  set home(Home home) {
    _home = home;
    notifyListeners();
  }

  Future<dynamic> GetHome({required String token}) async {
    try {
      Home home = await HomeService().GetHome(token: token);

      _home = home;

      print("LOADING");

      notifyListeners();

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception: ", "");
    }
  }
}

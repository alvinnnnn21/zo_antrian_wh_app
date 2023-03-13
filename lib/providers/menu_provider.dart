// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sutindo_supir_app/models/menu_model.dart';
import 'package:sutindo_supir_app/services/menu_service.dart';

class MenuProvider with ChangeNotifier {
  List<Menu> _menu = [];

  List<Menu> get menu => _menu;

  set menu(List<Menu> menu) {
    _menu = menu;
    notifyListeners();
  }

  Future<dynamic> GetMenu({required String token}) async {
    try {
      List<Menu> menu = await MenuService().GetMenu(token: token);

      _menu = menu;

      notifyListeners();

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception:", "");
    }
  }
}

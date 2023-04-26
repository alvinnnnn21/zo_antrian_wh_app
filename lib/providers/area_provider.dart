// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sutindo_supir_app/models/area_model.dart';
import 'package:sutindo_supir_app/services/area_service.dart';

class AreaProvider with ChangeNotifier {
  List<Area> _area = [];

  List<Area> get area => _area;

  set area(List<Area> area) {
    _area = area;
    notifyListeners();
  }

  Future<dynamic> GetArea() async {
    try {
      List<Area> area = await AreaService().GetArea();

      _area = area;

      notifyListeners();

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception: ", "");
    }
  }
}

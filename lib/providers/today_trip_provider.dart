// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sutindo_supir_app/models/today_trip_model.dart';
import 'package:sutindo_supir_app/services/today_trip_service.dart';

class TodayTripProvider with ChangeNotifier {
  TodayTrip _today = TodayTrip();

  TodayTrip get today => _today;

  set today(TodayTrip today) {
    _today = today;
    notifyListeners();
  }

  Future<dynamic> GetTodayTrip({required String token}) async {
    try {
      TodayTrip today = await TodayTripService().GetTodayTrip(token: token);

      _today = today;

      notifyListeners();

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception: ", "");
    }
  }
}

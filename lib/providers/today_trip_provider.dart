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

  Future<bool> GetTodayTrip({required String token}) async {
    try {
      TodayTrip today = await TodayTripService().GetTodayTrip(token: token);

      _today = today;

      notifyListeners();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

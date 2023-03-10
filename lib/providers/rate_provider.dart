import 'package:flutter/cupertino.dart';
import 'package:sutindo_supir_app/models/pocket_money_model.dart';
import 'package:sutindo_supir_app/models/rate_model.dart';
import 'package:sutindo_supir_app/services/rate_service.dart';

class RateProvider extends ChangeNotifier {
  Rate _rate = Rate();

  Rate get rate => _rate;

  set rate(Rate rate) {
    _rate = rate;
    notifyListeners();
  }

  Future<dynamic> GetRate({required String token, required int id}) async {
    try {
      Rate rate = await RateService().GetRate(token: token, id: id);

      _rate = rate;

      notifyListeners();

      return true;
    } catch (e) {
      print("Error : $e");
      return e.toString().replaceAll("Exception:", "");
    }
  }

  Future<dynamic> ActionUangSaku(
      {required String token, required int id, required String type}) async {
    try {
      bool response =
          await RateService().ActionUangSaku(token: token, id: id, type: type);

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception:", "");
    }
  }
}

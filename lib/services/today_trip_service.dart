// ignore_for_file: non_constant_identifier_names
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:sutindo_supir_app/api.dart';
import 'package:sutindo_supir_app/models/pocket_money_model.dart';
import 'package:sutindo_supir_app/models/today_trip_model.dart';
import 'package:http/http.dart' as http;

class TodayTripService {
  Future<TodayTrip> GetTodayTrip({required String token}) async {
    var url = '${API.baseURL}get-today-trip';
    var headers = {'Authorization': 'Bearer $token'};
    var body = {"id_area": API.getArea()};

    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List jka = [];
      List jpa = [];
      List<PocketMoney> list_pocket_money = [];

      if (data["status"] == 401) {
        final storage = GetStorage();

        storage.remove("token");
        storage.remove("name");
        storage.remove("id");
        throw Exception("401");
      }

      var keys = data["rates"]?.length > 0 ? data["rates"].keys.toList() : [];

      for (var i = 0; i < keys.length; i++) {
        var item = data["rates"][keys[i]];

        if (item["jka"] != null) jka.add(item["jka"]);
        if (item["jpa"] != null) jpa.add(item["jpa"]);
      }

      for (var i = 0; i < data["pengeluaran"].length; i++) {
        var item = data["pengeluaran"][i];

        list_pocket_money.add(PocketMoney.fromJson({
          "perusahaan": "",
          "purpose": item["keterangan"],
          "ammount": item["nominal"].toString(),
          "type": "",
          "status": "",
          "id": ""
        }));
      }

      TodayTrip today = TodayTrip.fromJson({
        "name": data["user"]["karyawan"].toString(),
        "jumlah_rate": data["jumlah_rate"],
        "tuntas_kirim": data["tuntas_kirim"],
        "tonase_kirim": data["tonase_kirim"].toString() + " kg",
        "jka": jka,
        "jpa": jpa,
        "list_pocket_money": list_pocket_money
      });

      return today;
    } else {
      throw Exception("Error");
    }
  }
}

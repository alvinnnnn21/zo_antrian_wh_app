// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:sutindo_supir_app/api.dart';
import 'package:http/http.dart' as http;
import 'package:sutindo_supir_app/models/home_model.dart';
import 'package:sutindo_supir_app/models/menu_model.dart';
import 'package:sutindo_supir_app/models/today_trip_model.dart';

class HomeService {
  Future<Home> GetHome({required String token}) async {
    var url = '${API.baseURL}get-user';
    var url2 = '${API.baseURL}get-today-trip';
    var headers = {'Authorization': 'Bearer $token'};
    var body = {"token": token, "id_area": API.getArea()};
    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    var response2 =
        await http.post(Uri.parse(url2), body: body, headers: headers);

    if (response.statusCode == 200 && response2.statusCode == 200) {
      var data = jsonDecode(response.body);
      var data2 = jsonDecode(response2.body);

      if (data["status"] == 401 || data2["status"] == 401) {
        final storage = GetStorage();

        storage.remove("token");
        storage.remove("name");
        storage.remove("id");
        throw Exception("401");
      }

      var rates = data["rates"];
      var keys = rates.keys.toList();

      List<Menu> list_menu = [];

      for (var i = 0; i < keys.length; i++) {
        var item = rates[keys[i]];

        if (keys[i] != "wip") {
          list_menu.add(Menu.fromJson({
            "label": 'Rate ${item["rate"]}',
            "url": "/rate",
            "id": item["id"]
          }));
        }
      }

      var wip = data["rates"]["wip"];

      Home home = Home.fromJson({
        "wip": wip == null
            ? {'isNull': true}
            : {
                "isNull": false,
                "id": wip["id"],
                "sopir": wip["nama_sopir"],
                "kernet": wip["nama_kernet"],
                "armada": wip["jenis_armada"],
                "nopol": wip["nopol"],
                "rate": wip["rate"].toString(),
                "customer": wip["customer_done"].toString() +
                    "/" +
                    wip["total_customer"].toString(),
                "kapasitas": wip["kapasitas"].toString(),
                "tonase":
                    wip["tonase_done"].toString() + "/" + wip["tonase_kirim"]
              },
        "list_menu": list_menu,
        "today": {
          "nama": data2["user"]["karyawan"],
          "jumlah_rate": data2["jumlah_rate"].toString(),
          "tuntas_kirim": data2["tuntas_kirim"].toString(),
          "tonase_kirim": data2["tonase_kirim"].toString() + " kg",
        }
      });

      return home;
    } else {
      throw Exception("Error");
    }
  }
}

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:sutindo_supir_app/api.dart';
import 'package:http/http.dart' as http;
import 'package:sutindo_supir_app/models/pengeluaran_model.dart';
import 'package:sutindo_supir_app/models/pocket_money_model.dart';

class PengeluaranService {
  Future<Pengeluaran> GetDetailPengeluaran(
      {required String token, required String id}) async {
    var url = '${API.baseURL}get-pengeluaran';
    var body = {"id": id, "id_area": API.getArea()};
    var headers = {'Authorization': 'Bearer $token'};

    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data["status"] == 401) {
        final storage = GetStorage();

        storage.remove("token");
        storage.remove("name");
        storage.remove("id");
        throw Exception("401");
      }

      List<PocketMoney> list_pocket_money = [];

      var key_uang_saku = data["uangSaku"].keys.toList();

      for (var i = 0; i < key_uang_saku.length; i++) {
        var item = data["uangSaku"][key_uang_saku[i]];

        if (item["nominal"].toString()[0] == "-") {
          list_pocket_money.add(PocketMoney.fromJson({
            "perusahaan": "",
            "purpose": item["keterangan"],
            "ammount": item["nominal"].toString().replaceAll("-", ""),
            "type": "",
            "status": item["status"].toString(),
            "id": item["id"].toString(),
          }));
        }
      }

      Pengeluaran pengeluaran = Pengeluaran.fromJson({
        "total_pengeluaran": data["total_pengeluaran"].toString(),
        "total_uang_saku": data["totalUangSaku"].toString(),
        "total_saldo": data["sisaUangSaku"].toString(),
        "list_pocket_money": list_pocket_money
      });

      return pengeluaran;
    } else {
      throw Exception("Error");
    }
  }
}

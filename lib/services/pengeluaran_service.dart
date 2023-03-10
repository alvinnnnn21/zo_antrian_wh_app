import 'dart:convert';

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

      List<PocketMoney> list_pocket_money = [];

      for (var i = 0; i < data["uangSaku"].length; i++) {
        var item = data["uangSaku"][i];

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
        "total_uang_saku": data["total_uang_saku"].toString(),
        "total_saldo": data["sisa_saldo"].toString(),
        "list_pocket_money": list_pocket_money
      });

      return pengeluaran;
    } else {
      throw Exception("Error");
    }
  }
}

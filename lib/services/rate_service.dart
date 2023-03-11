// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sutindo_supir_app/api.dart';
import 'package:sutindo_supir_app/models/lokasi_model.dart';
import 'package:sutindo_supir_app/models/pocket_money_model.dart';
import 'package:sutindo_supir_app/models/rate_model.dart';
import 'package:http/http.dart' as http;
import 'package:sutindo_supir_app/models/sj_model.dart';
import 'package:sutindo_supir_app/models/task_item_model.dart';
import 'package:sutindo_supir_app/models/task_model.dart';
import 'package:sutindo_supir_app/models/tonase_model.dart';

class RateService {
  Future<Rate> GetRate({required String token, required int id}) async {
    var url = '${API.baseURL}get-rate';
    var body = {"id": id.toString(), "id_area": API.getArea()};
    var headers = {'Authorization': 'Bearer $token'};

    print('token $body');

    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      final value = NumberFormat("#,##0", "en_US");

      List<Task> list_task = [];
      List<Tonase> list_tonase = [];
      List<PocketMoney> list_pocket_money = [];

      var key_lokasi = data["lokasi"].keys.toList();

      for (var i = 0; i < data["uang_saku"].length; i++) {
        var saku = data["uang_saku"][i];

        list_pocket_money.add(PocketMoney.fromJson({
          "perusahaan": saku["asal"].toString(),
          "purpose": saku["keterangan"].toString(),
          // "ammount": saku["nominal"].toString(),
          "ammount": data["total_uang_saku"],
          "type": saku["status"].toString(),
          "status": "",
          "id": saku["id"].toString()
        }));
      }

      for (var i = 0; i < key_lokasi.length; i++) {
        var key_item = key_lokasi[i];

        list_tonase.add(Tonase.fromJson({
          "keterangan": data["lokasi"][key_item]["nama_lokasi"],
          "jumlah": value.format(data["lokasi"][key_item]["tonase"])
        }));
      }

      list_tonase.add(Tonase.fromJson(
          {"keterangan": "Total", "jumlah": data["total_tonase"] + " kg"}));

      var key_detail = data["detail"].keys.toList();

      for (var i = 0; i < key_detail.length; i++) {
        var task = data["detail"][key_detail[i]];
        var key_sj = task["items"].keys.toList();

        List<SJ> list_sj = [];

        for (var j = 0; j < key_sj.length; j++) {
          List<TaskItem> list_task_item = [];
          var key_task_item = task["items"][key_sj[j]].keys.toList();

          for (var k = 0; k < key_task_item.length; k++) {}

          var task_item = task["items"][key_sj[j]];
          var lokasi = task_item["lokasi"];

          List<Lokasi> list_lokasi = [];

          for (var q = 0; q < lokasi.length; q++) {
            list_lokasi.add(Lokasi.fromJson(
                {"lokasi": lokasi[q]["nama_lokasi"], "same": false}));
          }

          // for (var x = 0; x < key_lokasi.length; x++) {
          //   list_lokasi.add(Lokasi.fromJson({
          //     "lokasi": data["lokasi"][key_lokasi[x]]["nama_lokasi"],
          //     "same": false
          //   }));
          // }

          // for (var y = 0; y < lokasi.length; y++) {
          //   for (var z = 0; z < list_lokasi.length; z++) {
          //     if (list_lokasi[z].lokasi == lokasi[y]["nama_lokasi"]) {
          //       list_lokasi[z].same = true;
          //     }
          //   }
          // }

          list_task_item.add(TaskItem.fromJson({
            "item": task_item["nama_item"],
            "weight": task_item["tonase"].toString(),
            "list_lokasi": list_lokasi
          }));

          list_sj.add(SJ.fromJson({
            "no": task["sj"][j],
            "list_task": list_task_item,
            "total_item": "",
            "total_weight": ""
          }));
        }

        list_task.add(Task.fromJson({
          "perusahaan": key_detail[i],
          "list_sj": list_sj,
          "total_item": "",
          "total_weight": "",
          "description": "",
          "status": "",
          "id": "",
          "selesai": "",
          "mulai": "",
          "sampai": "",
          "batal": "",
          "progress_eksternal": 0,
          "is_show": false,
          "is_enable": false,
        }));
      }

      Rate rate = Rate.fromJson({
        "nopol": data["nopol"],
        "armada": data["jenis_armada"],
        "sopir": data["nama_sopir"],
        "tonase_kirim": data["total_tonase"] + " kg",
        "rate": data["rate"].toString(),
        "kapasitas": data["kapasitas"],
        "kernet": data["nama_kernet"],
        "total_sj": data["total_sj"],
        "status_kapasitas": data["status_kapasitas"],
        "list_task": list_task,
        "list_tonase": list_tonase,
        "list_pocket_money": list_pocket_money,
      });

      return rate;
    } else {
      throw Exception("Error");
    }
  }

  Future<dynamic> ActionUangSaku(
      {required String token, required int id, required String type}) async {
    var url =
        '${API.baseURL}${type == "sign" ? "sign-uang-saku" : "reject-uang-saku"}';
    var body = {"id": id.toString(), "id_area": API.getArea()};
    var headers = {'Authorization': 'Bearer $token'};

    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data["status"] == 200) {
        return true;
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception("Error");
    }
  }
}

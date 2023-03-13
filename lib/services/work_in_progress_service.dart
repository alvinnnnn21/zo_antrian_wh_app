// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sutindo_supir_app/api.dart';
import 'package:sutindo_supir_app/models/lokasi_model.dart';
import 'package:sutindo_supir_app/models/pocket_money_model.dart';
import 'package:sutindo_supir_app/models/sj_model.dart';
import 'package:sutindo_supir_app/models/task_item_model.dart';
import 'package:sutindo_supir_app/models/task_model.dart';
import 'package:sutindo_supir_app/models/work_in_progress_model.dart';
import 'package:http/http.dart' as http;

class WorkInProgressService {
  String getStatus(int progress) {
    switch (progress) {
      case 1:
        return "On The Way";
      case 2:
        return "Sampai";
      case 3:
        return "Mulai";
      case 4:
        return "Done";
      default:
        return "On The Way";
    }
  }

  Future<WorkInProgress> GetWorkInProgress(
      {required String token, required int id, requi}) async {
    var url = '${API.baseURL}get-rate';
    var body = {"id": id.toString(), "id_area": API.getArea()};
    var headers = {'Authorization': 'Bearer $token'};

    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<Task> list_task = [];
      List<PocketMoney> list_pocket_money = [];

      for (var i = 0; i < data["uang_saku"].length; i++) {
        var saku = data["uang_saku"][i];

        list_pocket_money.add(PocketMoney.fromJson({
          "perusahaan": saku["asal"].toString(),
          "purpose": saku["keterangan"].toString(),
          "ammount": saku["nominal"].toString(),
          "type": saku["status"].toString(),
          "status": "",
          "id": ""
        }));
      }

      var key_detail = data["detail"].keys.toList();

      for (var i = 0; i < key_detail.length; i++) {
        var task = data["detail"][key_detail[i]];
        var key_sj = task["sj"].keys.toList();

        List<SJ> list_sj = [];

        for (var j = 0; j < key_sj.length; j++) {
          // var task_item = task["sj"][key_sj[j]][key_sj[j]];
          var key_task_item = task["sj"][key_sj[j]].keys.toList();

          List<TaskItem> list_task_item = [];

          for (var k = 0; k < key_task_item.length; k++) {
            var task_item = task["sj"][key_sj[j]][key_task_item[k]];

            list_task_item.add(TaskItem.fromJson({
              "item": task_item["nama_item"],
              "weight": task_item["tonase"] + "kg",
              "list_lokasi": []
            }));
          }

          list_sj.add(SJ.fromJson({
            "no": key_sj[j],
            "list_task": list_task_item,
            "total_item": list_task_item.length.toString(),
            "total_weight": task["total_tonase"].toString() + "kg",
          }));
        }

        list_task.add(Task.fromJson({
          "perusahaan": key_detail[i],
          "list_sj": list_sj,
          "total_item": "",
          "total_weight": "",
          "description": "",
          "status": getStatus(task["progress_eksternal"]),
          "id": task["id"].toString(),
          "selesai": task["selesai"] ?? "-",
          "mulai": task["mulai"] ?? "-",
          "sampai": task["sampai"] ?? "-",
          "batal": task["batal"] ?? "-",
          "progress_eksternal": task["progress_eksternal"],
          "is_show": false,
          "is_enable": false,
          "no_urut": task["no_urut"]
        }));
      }

      for (var i = 0; i < list_task.length; i++) {
        if (i == 0) {
          if (list_task[0].progress_eksternal == 4) {
            list_task[0].is_enable = false;
          } else {
            list_task[0].is_enable = true;
          }
        } else if (i > 0) {
          if (list_task[i - 1].progress_eksternal == 4) {
            list_task[i].is_enable = true;
          }
        }
      }

      WorkInProgress work = WorkInProgress.fromJson({
        "nopol": data["nopol"],
        "armada": data["jenis_armada"],
        "sopir": data["nama_sopir"],
        "tonase_kirim": data["tonase_kirim"] + " kg",
        "rate": "Rate " + data["rate"].toString(),
        "kapasitas": data["kapasitas"],
        "kernet": data["nama_kernet"],
        "total_sj": data["total_sj"],
        "total_item": data["total_jumlah"],
        "list_task": list_task,
        "list_pocket_money": list_pocket_money,
        "total_pocket_money": data["total_uang_saku"].toString(),
        "id": data["id"].toString(),
        "total_berat": data["total_tonase"].toString(),
        "total_saldo": data["sisa_saldo"].toString(),
        "total_pengeluaran": data["total_pengeluaran"].toString(),
      });

      return work;
    } else {
      throw Exception("Error");
    }
  }

  Future<bool> AddPocketMoney(
      {required String token,
      required String nominal,
      required String keterangan,
      required String id}) async {
    var url = '${API.baseURL}add-pengeluaran';
    var body = {
      "id": id,
      "keterangan": keterangan,
      "nominal": nominal,
      "id_area": API.getArea()
    };
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

  Future<bool> UpdateProgress(
      {required String token,
      required String keterangan,
      required String id,
      required String customer,
      required String progress,
      required int no_urut}) async {
    var url = '${API.baseURL}update-progress';
    var body = {
      "id": id,
      "keterangan": keterangan,
      progress: "1",
      "customer": customer,
      "id_area": API.getArea(),
      "no_urut": no_urut.toString()
    };

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

  Future<bool> HapusRute(
      {required String token,
      required String keterangan,
      required String id,
      required String customer,
      required String no_urut}) async {
    var url = '${API.baseURL}hapus-rute';
    var body = {
      "id": id,
      "no_urut": no_urut,
      "keterangan": keterangan,
      "customer": customer,
      "id_area": API.getArea()
    };
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

  Future<bool> EditPocketMoney(
      {required String token,
      required String nominal,
      required String keterangan,
      required String id}) async {
    var url = '${API.baseURL}edit-pengeluaran';
    var body = {
      "id": id,
      "keterangan": keterangan,
      "nominal": nominal,
      "id_area": API.getArea()
    };
    var headers = {'Authorization': 'Bearer $token'};

    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception;
    }
  }
}

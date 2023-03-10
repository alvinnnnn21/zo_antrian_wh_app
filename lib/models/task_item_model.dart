import 'package:flutter/material.dart';

class TaskItem {
  String item = "";
  String weight = "";
  List list_lokasi = [];

  TaskItem({this.item = "", this.weight = "", this.list_lokasi = const []});

  TaskItem.fromJson(Map<String, dynamic> json) {
    item = json["item"];
    weight = json["weight"];
    list_lokasi = json["list_lokasi"];
  }

  Map<String, dynamic> toJson() {
    return {"item": item, "weight": weight, "list_lokasi": list_lokasi};
  }
}

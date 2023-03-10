import 'package:flutter/material.dart';

class Menu {
  String label = "";
  String url = "";
  int id = 0;

  Menu({this.label = "", this.url = "", this.id = 0});

  Menu.fromJson(Map<String, dynamic> json) {
    label = json["label"];
    url = json["url"];
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    return {"label": label, "url": url, "id": id};
  }
}

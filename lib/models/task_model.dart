import 'package:sutindo_supir_app/models/sj_model.dart';

class Task {
  String perusahaan = "";
  List<SJ> list_sj = [];
  String total_item = "";
  String total_weight = "";
  String description = "";
  String status = "";
  String id = "";
  String selesai = "";
  String mulai = "";
  String sampai = "";
  String batal = "";
  int no_urut = 0;
  int progress_eksternal = 0;
  bool is_show = false;
  bool is_enable = false;

  Task(
      {this.perusahaan = "",
      this.list_sj = const [],
      this.total_item = "",
      this.description = "",
      this.status = "",
      this.id = "",
      this.selesai = "",
      this.mulai = "",
      this.sampai = "",
      this.batal = "",
      this.progress_eksternal = 0,
      this.is_show = false,
      this.is_enable = false,
      this.no_urut = 0});

  Task.fromJson(Map<String, dynamic> json) {
    perusahaan = json["perusahaan"];
    list_sj = json["list_sj"];
    total_item = json["total_item"];
    total_weight = json["total_weight"];
    description = json["description"];
    status = json["status"];
    id = json["id"];
    selesai = json["selesai"];
    mulai = json["mulai"];
    sampai = json["sampai"];
    batal = json["batal"];
    progress_eksternal = json["progress_eksternal"];
    is_show = json["is_show"];
    is_enable = json["is_enable"];
    no_urut = json["no_urut"];
  }

  Map<String, dynamic> toJson() {
    return {
      "perusahaan": perusahaan,
      "list_sj": list_sj,
      "total_item": total_item,
      "total_weight": total_weight,
      "description": description,
      "status": status,
      "id": id,
      "selesai": selesai,
      "mulai": mulai,
      "sampai": sampai,
      "batal": batal,
      "progress_eksternal": progress_eksternal,
      "is_show": is_show,
      "is_enable": is_enable,
      "no_urut": no_urut
    };
  }
}

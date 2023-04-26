import 'package:sutindo_supir_app/models/pocket_money_model.dart';
import 'package:sutindo_supir_app/models/task_model.dart';
import 'package:sutindo_supir_app/models/tonase_model.dart';

class Rate {
  String id = "";
  String nopol = "";
  String armada = "";
  String sopir = "";
  String tonase_kirim = "";
  String rate = "";
  String kapasitas = "";
  String kernet = "";
  int total_sj = 0;
  String status_kapasitas = "";
  List<Task> list_task = [];
  List<Tonase> list_tonase = [];
  List<PocketMoney> list_pocket_money = [];

  Rate(
      {this.id = "",
      this.nopol = "",
      this.armada = "",
      this.sopir = "",
      this.tonase_kirim = "",
      this.rate = "",
      this.kapasitas = "",
      this.kernet = "",
      this.total_sj = 0,
      this.status_kapasitas = "",
      this.list_task = const [],
      this.list_pocket_money = const [],
      this.list_tonase = const []});

  Rate.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    nopol = json["nopol"];
    armada = json["armada"];
    sopir = json["sopir"];
    tonase_kirim = json["tonase_kirim"];
    rate = json["rate"];
    kapasitas = json["kapasitas"];
    kernet = json["kernet"];
    total_sj = json["total_sj"];
    status_kapasitas = json["status_kapasitas"];
    list_task = json["list_task"];
    list_pocket_money = json["list_pocket_money"];
    list_tonase = json["list_tonase"];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nopol": nopol,
      "armada": armada,
      "sopir": sopir,
      "tonase_kirim": tonase_kirim,
      "rate": rate,
      "kapasitas": kapasitas,
      "kernet": kernet,
      "total_sj": total_sj,
      "status_kapasitas": status_kapasitas,
      "list_task": list_task,
      "list_pocket_money": list_pocket_money,
      "list_tonase": list_tonase,
    };
  }
}

import 'package:sutindo_supir_app/models/pocket_money_model.dart';
import 'package:sutindo_supir_app/models/task_model.dart';

class WorkInProgress {
  String nopol = "";
  String armada = "";
  String sopir = "";
  String tonase_kirim = "";
  String rate = "";
  String kapasitas = "";
  String kernet = "";
  int total_sj = 0;
  String total_item = "";
  List<Task> list_task = [];
  List<PocketMoney> list_pocket_money = [];
  String total_pocket_money = "";
  String total_saldo = "";
  String total_pengeluaran = "";
  String id = "";
  String total_berat = "";

  WorkInProgress(
      {this.nopol = "",
      this.armada = "",
      this.sopir = "",
      this.tonase_kirim = "",
      this.rate = "",
      this.kapasitas = "",
      this.kernet = "",
      this.total_sj = 0,
      this.total_item = "",
      this.list_task = const [],
      this.list_pocket_money = const [],
      this.total_pocket_money = "",
      this.total_saldo = "",
      this.total_pengeluaran = "",
      this.id = "",
      this.total_berat = ""});

  WorkInProgress.fromJson(Map<String, dynamic> json) {
    nopol = json["nopol"];
    armada = json["armada"];
    sopir = json["sopir"];
    tonase_kirim = json["tonase_kirim"];
    rate = json["rate"];
    kapasitas = json["kapasitas"];
    kernet = json["kernet"];
    total_sj = json["total_sj"];
    total_item = json["total_item"];
    list_task = json["list_task"];
    list_pocket_money = json["list_pocket_money"];
    total_pocket_money = json["total_pocket_money"];
    total_saldo = json["total_saldo"];
    total_pengeluaran = json["total_pengeluaran"];
    id = json["id"];
    total_berat = json["total_berat"];
  }

  Map<String, dynamic> toJson() {
    return {
      "nopol": nopol,
      "armada": armada,
      "sopir": sopir,
      "tonase_kirim": tonase_kirim,
      "rate": rate,
      "kapasitas": kapasitas,
      "kernet": kernet,
      "total_sj": total_sj,
      "total_item": total_item,
      "list_task": list_task,
      "list_pocket_money": list_pocket_money,
      "total_pocket_money": total_pocket_money,
      "total_saldo": total_saldo,
      "total_pengeluaran": total_pengeluaran,
      "id": id,
      "total_berat": total_berat,
    };
  }
}

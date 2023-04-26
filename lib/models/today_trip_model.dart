import 'package:sutindo_supir_app/models/pocket_money_model.dart';

class TodayTrip {
  String name = "";
  int jumlah_rate = 0;
  int tuntas_kirim = 0;
  String tonase_kirim = "";
  List jka = [];
  List jpa = [];
  List<PocketMoney> list_pocket_money = [];

  TodayTrip(
      {this.name = "",
      this.jumlah_rate = 0,
      this.tuntas_kirim = 0,
      this.tonase_kirim = "",
      this.jka = const [],
      this.jpa = const [],
      this.list_pocket_money = const []});

  TodayTrip.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    jumlah_rate = json["jumlah_rate"];
    tuntas_kirim = json["tuntas_kirim"];
    tonase_kirim = json["tonase_kirim"];
    jka = json["jka"];
    jpa = json["jpa"];
    list_pocket_money = json["list_pocket_money"];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "jumlah_rate": jumlah_rate,
      "tuntas_kirim": tuntas_kirim,
      "tonase_kirim": tonase_kirim,
      "jka": jka,
      "jpa": jpa,
      "list_pocket_money": list_pocket_money
    };
  }
}

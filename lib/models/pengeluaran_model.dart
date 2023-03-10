import 'package:sutindo_supir_app/models/pocket_money_model.dart';

class Pengeluaran {
  String total_pengeluaran = "";
  String total_uang_saku = "";
  String total_saldo = "";
  List<PocketMoney> list_pocket_money = [];

  Pengeluaran(
      {this.total_pengeluaran = "",
      this.total_uang_saku = "",
      this.total_saldo = "",
      this.list_pocket_money = const []});

  Pengeluaran.fromJson(Map<String, dynamic> json) {
    total_pengeluaran = json['total_pengeluaran'];
    total_uang_saku = json['total_uang_saku'];
    total_saldo = json['total_saldo'];
    list_pocket_money = json['list_pocket_money'];
  }

  Map<String, dynamic> toJson() {
    return {
      "total_pengeluaran": total_pengeluaran,
      "total_uang_saku": total_uang_saku,
      "total_saldo": total_saldo,
      "list_pocket_money": list_pocket_money
    };
  }
}

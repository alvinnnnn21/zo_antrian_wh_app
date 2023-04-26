class PocketMoney {
  String perusahaan = "";
  String purpose = "";
  String ammount = "";
  String type = "";
  String status = "";
  String id = "";

  PocketMoney({
    this.perusahaan = "",
    this.purpose = "",
    this.ammount = "",
    this.type = "",
    this.status = "",
    this.id = "",
  });

  PocketMoney.fromJson(Map<String, dynamic> json) {
    perusahaan = json['perusahaan'];
    purpose = json['purpose'];
    ammount = json['ammount'];
    type = json['type'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      "perusahaan": perusahaan,
      "purpose": purpose,
      "ammount": ammount,
      "type": type,
      "status": status,
      "id": id
    };
  }
}

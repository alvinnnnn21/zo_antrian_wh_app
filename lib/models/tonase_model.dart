class Tonase {
  String keterangan = "";
  String jumlah = "";

  Tonase({
    this.keterangan = "",
    this.jumlah = "",
  });

  Tonase.fromJson(Map<String, dynamic> json) {
    keterangan = json['keterangan'];
    jumlah = json['jumlah'];
  }

  Map<String, dynamic> toJson() {
    return {"keterangan": keterangan, "jumlah": jumlah};
  }
}

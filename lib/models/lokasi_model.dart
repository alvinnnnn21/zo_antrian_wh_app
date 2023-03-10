class Lokasi {
  String lokasi = '';
  bool same = false;

  Lokasi({this.lokasi = "", this.same = false});

  Lokasi.fromJson(Map<String, dynamic> json) {
    lokasi = json['lokasi'];
    same = json['same'];
  }

  Map<String, dynamic> toJson() {
    return {"lokasi": lokasi, "same": same};
  }
}

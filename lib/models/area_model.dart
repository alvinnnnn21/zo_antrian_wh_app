class Area {
  String areaID = "";
  String areaName = "";

  Area({this.areaID = "", this.areaName = ""});

  Area.fromJson(Map<String, dynamic> json) {
    areaID = json["areaID"];
    areaName = json["areaName"];
  }

  Map<String, dynamic> toJson() {
    return {"areaID": areaID, "areaName": areaName};
  }
}

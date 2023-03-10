class User {
  int id = 0;
  String name = "";
  String token = "";

  User({this.id = 0, this.name = "", this.token = ""});

  User.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    token = json["token"];
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "token": token};
  }
}

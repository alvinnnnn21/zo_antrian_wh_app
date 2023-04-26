import 'package:sutindo_supir_app/models/menu_model.dart';

class Home {
  Map<String, dynamic> wip = {};
  List<Menu> list_menu = [];
  Map<String, dynamic> today = {"isNull": true};

  Home(
      {this.wip = const {"isNull": true},
      this.list_menu = const [],
      this.today = const {}});

  Home.fromJson(Map<String, dynamic> json) {
    wip = json["wip"];
    list_menu = json["list_menu"];
    today = json["today"];
  }

  Map<String, dynamic> toJson() {
    return {"wip": wip, "list_menu": list_menu, "today": today};
  }
}

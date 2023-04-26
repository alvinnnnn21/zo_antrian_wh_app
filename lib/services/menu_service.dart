import 'dart:convert';
import 'package:sutindo_supir_app/api.dart';
import 'package:sutindo_supir_app/models/menu_model.dart';
import 'package:http/http.dart' as http;

class MenuService {
  Future<List<Menu>> GetMenu({required String token}) async {
    var url = '${API.baseURL}get-user';
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var body = {"id_area": API.getArea()};

    var response =
        await http.post(Uri.parse(url), body: body, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      var keys = data["rates"].keys.toList();

      List<Menu> menu = [];

      for (var i = 0; i < keys.length; i++) {
        var item = keys[i].toString();

        if (item == "wip") {
          if (data["rates"][item] != null) {
            menu.add(Menu.fromJson({
              "label": "Work In Progress",
              "url": "/work-in-progress",
              "id": data["rates"][item]["id"]
            }));
          }
        } else {
          menu.add(Menu.fromJson({
            "label": 'Rate ${data["rates"][item]["id"]}',
            "url": "/rate",
            "id": data["rates"][item]["id"]
          }));
        }
      }

      menu.add(Menu.fromJson(
          {"label": "Today's Trip", "url": "/today-trip", "id": 0}));

      return menu;
    } else {
      throw Exception("Error");
    }
  }
}

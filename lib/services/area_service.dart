import 'package:sutindo_supir_app/api.dart';
import 'package:sutindo_supir_app/models/area_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AreaService {
  Future<List<Area>> GetArea() async {
    var url = '${API.baseURL}get-db-list';

    var response = await http.post(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      List<Area> list_area = [];

      list_area.add(Area.fromJson({"areaID": "", "areaName": "Pilih Area"}));

      for (var i = 0; i < data.length; i++) {
        var item = data[i];

        list_area.add(Area.fromJson({
          "areaID": item["AreaID"].toString(),
          "areaName": item["AreaName"],
        }));
      }

      return list_area;
    } else {
      throw Exception("Error");
    }
  }
}

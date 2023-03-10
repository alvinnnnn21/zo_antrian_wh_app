import 'package:sutindo_supir_app/models/task_item_model.dart';

class SJ {
  String no = "";
  List<TaskItem> list_task = [];
  String total_item = "";
  String total_weight = "";

  SJ({this.no = "", list_task = const [], total_item = "", total_weight = ""});

  SJ.fromJson(Map<String, dynamic> json) {
    no = json["no"];
    list_task = json["list_task"];
    total_item = json["total_item"];
    total_weight = json["total_weight"];
  }

  Map<String, dynamic> toJson() {
    return {
      "no": no,
      "list_task": list_task,
      "total_item": total_item,
      "total_weight": total_weight
    };
  }
}

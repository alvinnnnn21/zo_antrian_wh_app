import 'package:get_storage/get_storage.dart';

class API {
  static String baseURL = "http://swmsapp.sutindo.net:8081/wh/web/api/";
  static String apiKey = "ZeroOne-SWMS-0101";

  static String getArea() {
    final storage = GetStorage();

    return storage.read("area");
  }
}

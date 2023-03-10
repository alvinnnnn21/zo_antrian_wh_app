import 'dart:convert';
import 'package:sutindo_supir_app/api.dart';
import 'package:sutindo_supir_app/models/user_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<User> Login(
      {required String username, required String password}) async {
    var url = '${API.baseURL}login';
    var body = {
      "userid": username,
      'password': password,
      "key": API.apiKey,
    };

    var response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      if (data.containsKey("token")) {
        User user =
            User.fromJson({"id": 0, "name": username, "token": data["token"]});

        final storage = GetStorage();
        storage.write("id", user.id);
        storage.write("token", user.token);
        storage.write("name", user.name);

        return user;
      } else {
        throw Exception(data["message"]);
      }
    } else {
      throw Exception("Error");
    }
  }
}

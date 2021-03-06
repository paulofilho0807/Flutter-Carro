import 'dart:convert';

import 'package:car/pages/apiResponse.dart';
import 'package:car/pages/usuario.dart';
import 'package:http/http.dart' as http;

class loginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

    Map<String, String> headers = {
      "Content-Type": "application/json",
    };

    Map params = {"username": login, "password": senha};

    String s = json.encode(params);
    print(url);
    print(">> $s");

    var response = await http.post(url, body: s, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      final user = Usuario.formJson(mapResponse);

      return ApiResponse.ok(user);
    }
    return ApiResponse.error(mapResponse["error"]);
  }
}

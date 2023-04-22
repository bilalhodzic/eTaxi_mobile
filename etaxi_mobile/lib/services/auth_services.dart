import 'dart:convert';
import 'dart:developer';

import 'package:etaxi_mobile/api/api_model.dart';
import 'package:etaxi_mobile/providers/auth_provider.dart';
import 'package:http/http.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthServices {
  static Future loginService(data) async {
    Response res =
        await ApiModels().postRequest(url: 'api/Auth/login', data: data);
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      var token = decoded['token'];
      AuthProvider.instance.setToken(token);

      //await AuthService.getUser(int.parse(decoded['id']));
      print('heree');
    } else {
      AuthProvider.instance.setError(jsonDecode(res.body)['ERROR'][0], 'login');
    }

    return res;
  }

  static Future registerService(data) async {
    Response res =
        await ApiModels().postRequest(url: 'api/Auth/register', data: data);
    inspect(res);
    if (res.statusCode == 200) {
      var token = jsonDecode(res.body)['Token'];
      AuthProvider.instance.setToken(token);

      var parsedToken = Jwt.parseJwt(token ?? '');
      //await UserService.getUser(int.parse(parsedToken['UserId']));
    } else {
      AuthProvider.instance
          .setError(jsonDecode(res.body)['ERROR'][0], 'register');
    }

    return res;
  }

  static Future forgotPassword(data) async {
    Response res = await ApiModels()
        .postRequest(url: 'api/Auth/forgotpassword', data: data);
    inspect(res);
    if (res.statusCode == 200) {}
  }
}

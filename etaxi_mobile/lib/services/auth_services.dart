import 'dart:convert';
import 'dart:developer';

import 'package:etaxi_mobile/api/api_model.dart';
import 'package:etaxi_mobile/models/user_model.dart';
import 'package:etaxi_mobile/providers/auth_provider.dart';
import 'package:flutter/animation.dart';
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
      await getUser(decoded['id']);
    } else {
      throw jsonDecode(res.body)["title"];
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
    } else {
      AuthProvider.instance.setError(jsonDecode(res.body)["title"], 'register');
    }

    return res;
  }

  static Future forgotPassword(data) async {
    Response res = await ApiModels()
        .postRequest(url: 'api/Auth/forgot-password', data: data);
    inspect(res);
    if (res.statusCode == 200) {
    } else {
      throw Exception('Greska prilikom slanja linka za ponistavanje sifre');
    }
  }

  static Future resetPassword(data) async {
    Response res = await ApiModels()
        .postRequest(url: 'api/Auth/reset-password', data: data);
    inspect(res);
    if (res.statusCode == 200) {
    } else {
      throw jsonDecode(res.body)['title'];
    }
  }

  static Future getUser(int id) async {
    Response res = await ApiModels().getRequest(url: 'api/User/$id');
    if (res.statusCode == 200) {
      var decoded = jsonDecode(res.body);
      AuthProvider.instance.setUser(Userinfo.fromJson(decoded));
    }

    return res;
  }
}
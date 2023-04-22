import 'dart:developer';
import 'package:etaxi_mobile/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
//singleton
  static AuthProvider? _instance;
  static AuthProvider get instance {
    if (_instance == null) {
      _instance = AuthProvider._();
    }

    return _instance!;
  }

  AuthProvider._();
  AuthProvider._internal();

  Userinfo? _user;
  Userinfo? get user => _user;

  String? token;
  String? loginError;
  String? registerError;

  Future<void> setUser(Userinfo? usr) async {
    _user = usr;
  }

  setError(err, String type) {
    if (type == 'login') {
      loginError = err;
    } else if (type == 'register') {
      registerError = err;
    }
    notifyListeners();
  }

  setToken(token) {
    token = token;
    notifyListeners();
  }
}

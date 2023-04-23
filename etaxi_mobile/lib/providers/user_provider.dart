import 'dart:developer';

import 'package:etaxi_mobile/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  static Userinfo? _user;
  Userinfo? get user => _user;

  static void setUser(Userinfo? usr) {
    _user = usr;
    // inspect(_user);
  }
}

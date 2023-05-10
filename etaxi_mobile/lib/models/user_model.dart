import 'dart:ffi';
import 'package:flutter/cupertino.dart';

class Userinfo {
  int? id;
  @required
  String? firstName;
  @required
  String? lastName;
  String? userType;
  DateTime? userCreatedTime;
  bool? isActive;
  bool? verifiedAccount;
  int? locationId;
  String? userName;
  int? pin;
  String? phoneNumber;
  String? email;
  String? phoneCode;
  String? photoUrl;

  Userinfo({
    this.id,
    this.userName,
    this.phoneNumber,
    this.phoneCode,
    this.email,
    this.photoUrl,
    this.firstName,
    this.lastName,
    this.isActive,
    this.userCreatedTime,
    this.locationId,
    this.pin,
    this.userType,
    this.verifiedAccount,
  });

  Userinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    pin = json['pin'] ?? 0;
    email = json['email'] ?? '';
    //userType = json['UserType'];
    //isActive = json['IsActive'];
    //userCreatedTime = DateTime.parse(json['UserCreatedTime']);
    // verifiedAccount = json['VerifiedAccount'] ?? 0;
  }
}

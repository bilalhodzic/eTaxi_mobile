import 'dart:ffi';
import 'package:flutter/cupertino.dart';

class Userinfo {
  int? id;
  @required
  String? firstName;
  @required
  String? lastName;
  @required
  String? userType;
  @required
  DateTime? userCreatedTime;
  @required
  bool? isActive;
  @required
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

  Userinfo.fromJson(json) {
    id = json['Id'];
    firstName = json['FirstName'];
    lastName = json['LastName'];
    pin = json['Pin'] ?? 0;
    userType = json['UserType'];
    isActive = json['IsActive'];
    userCreatedTime = DateTime.parse(json['UserCreatedTime']);
    verifiedAccount = json['VerifiedAccount'] ?? 0;
  }
}

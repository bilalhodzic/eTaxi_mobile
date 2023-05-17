import 'dart:ffi';
import 'package:etaxi_mobile/models/file_model.dart';
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
  List<FileModel>? files;

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
    this.files,
  });

  Userinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    pin = json['pin'] ?? 0;
    email = json['email'] ?? '';
    files = json['files'] != null
        ? (json['files'] as List).map((i) => FileModel.fromJson(i)).toList()
        : null;
    //userType = json['UserType'];
    //isActive = json['IsActive'];
    //userCreatedTime = DateTime.parse(json['UserCreatedTime']);
    // verifiedAccount = json['VerifiedAccount'] ?? 0;
  }
}

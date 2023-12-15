// To parse this JSON data, do
//
//     final staffUser = staffUserFromJson(jsonString);

import 'dart:convert';

import 'package:login_app/model/usermodel.dart';

import 'officemodel.dart';

StaffUser staffUserFromJson(String str) => StaffUser.fromJson(json.decode(str));

String staffUserToJson(StaffUser data) => json.encode(data.toJson());

class StaffUser {
  int staffId;
  String userName;
  String email;
  String telephone;
  String dateOfBirth;
  String drivingLicenseNumber;
  String area;
  String businessTrip;
  String macAddress;
  User userAccount;
  Office affiliatedOffice;

  StaffUser({
    required this.staffId,
    required this.userName,
    required this.email,
    required this.telephone,
    required this.dateOfBirth,
    required this.drivingLicenseNumber,
    required this.area,
    required this.businessTrip,
    required this.macAddress,
    required this.userAccount,
    required this.affiliatedOffice,
  });

  factory StaffUser.fromJson(Map<String, dynamic> json) => StaffUser(
    staffId: json["staffId"],
    userName: json["userName"],
    email: json["email"],
    telephone: json["telephone"],
    dateOfBirth: json["dateOfBirth"],
    drivingLicenseNumber: json["drivingLicenseNumber"],
    area: json["area"],
    businessTrip: json["businessTrip"],
    macAddress: json["macAddress"],
    userAccount: User.fromJson(json["userAccount"]),
    affiliatedOffice: Office.fromJson(json["affiliatedOffice"]),
  );

  Map<String, dynamic> toJson() => {
    "staffId": staffId,
    "userName": userName,
    "email": email,
    "telephone": telephone,
    "dateOfBirth": dateOfBirth,
    "drivingLicenseNumber": drivingLicenseNumber,
    "area": area,
    "businessTrip": businessTrip,
    "macAddress": macAddress,
    "userAccount": userAccount.toJson(),
    "affiliatedOffice": affiliatedOffice.toJson(),
  };
}





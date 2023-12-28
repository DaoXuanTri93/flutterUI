// To parse this JSON data, do
//
//     final staffUser = staffUserFromJson(jsonString);

import 'dart:convert';

StaffUser staffUserFromJson(String str) => StaffUser.fromJson(json.decode(str));

String staffUserToJson(StaffUser data) => json.encode(data.toJson());


class StaffUser {
  int id;
  String userAccount;
  String userName;
  String email;
  String telephone;
  String affiliatedOffice;
  String role;
  String mac;

  StaffUser({
    required this.id,
    required this.userAccount,
    required this.userName,
    required this.email,
    required this.telephone,
    required this.affiliatedOffice,
    required this.role,
    required this.mac,
  });


  factory StaffUser.fromJson(Map<String, dynamic> json) => StaffUser(
    id: json["id"],
    userAccount: json["userAccount"],
    userName: json["userName"],
    email: json["email"],
    telephone: json["telephone"],
    affiliatedOffice: json["affiliatedOffice"],
    role: json["role"],
    mac: json["MAC"],
  );

  Map<String, dynamic> toJson() => {
    "id": id.toString(),
    "userAccount": userAccount,
    "userName": userName,
    "email": email,
    "telephone": telephone,
    "affiliatedOffice": affiliatedOffice,
    "role": role,
    "MAC": mac,
  };
  static List<StaffUser> fromData(List<dynamic> data) {
    return data.map((e) => StaffUser.fromJson(e)).toList();
  }
}

// To parse this JSON data, do
//
//     final staffUser = staffUserFromJson(jsonString);

import 'dart:convert';

OfficeUser staffUserFromJson(String str) => OfficeUser.fromJson(json.decode(str));

String staffUserToJson(OfficeUser data) => json.encode(data.toJson());

class OfficeUser {
  int id;
  String baseName;

  OfficeUser({
    required this.id,
    required this.baseName,
  });

  factory OfficeUser.fromJson(Map<String, dynamic> json) => OfficeUser(
    id: json["id"],
    baseName: json["baseName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "baseName": baseName,
  };
}

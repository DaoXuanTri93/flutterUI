
import 'dart:convert';

SearchUser staffUserFromJson(String str) => SearchUser.fromJson(json.decode(str));

String staffUserToJson(SearchUser data) => json.encode(data.toJson());

class SearchUser {
  int id;
  String role;

  SearchUser({
    required this.id,
    required this.role,
  });

  factory SearchUser.fromJson(Map<String, dynamic> json) => SearchUser(
    id: json["id"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
  };
}

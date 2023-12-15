class User {
  int id;
  String username;
  String password;
  String role;
  String mac;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.role,
    required this.mac,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    password: json["password"],
    role: json["role"],
    mac: json["MAC"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
    "role": role,
    "MAC": mac,
  };
}
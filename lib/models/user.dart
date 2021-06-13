// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.code,
    this.description,
    this.user,
  });

  String code;
  String description;
  UserClass user;

  factory User.fromJson(Map<String, dynamic> json) => User(
    code: json["code"] == null ? null : json["code"],
    description: json["description"] == null ? null : json["description"],
    user: json["user"] == null ? null : UserClass.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "description": description == null ? null : description,
    "user": user == null ? null : user.toJson(),
  };
}

class UserClass {
  UserClass({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.status,
    this.emailVerifiedAt,
    this.type,
    this.department,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  String mobile;
  int status;
  dynamic emailVerifiedAt;
  String type;
  String department;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    status: json["status"] == null ? null : json["status"],
    emailVerifiedAt: json["email_verified_at"],
    type: json["type"] == null ? null : json["type"],
    department: json["department"] == null ? null : json["department"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "mobile": mobile == null ? null : mobile,
    "status": status == null ? null : status,
    "email_verified_at": emailVerifiedAt,
    "type": type == null ? null : type,
    "department": department == null ? null : department,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

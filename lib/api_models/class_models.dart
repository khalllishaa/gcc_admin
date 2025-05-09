// To parse this JSON data, do
//
//     final classModel = classModelFromJson(jsonString);

import 'dart:convert';

List<ClassModel> classModelFromJson(String str) => List<ClassModel>.from(json.decode(str).map((x) => ClassModel.fromJson(x)));

String classModelToJson(List<ClassModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClassModel {
  int id;
  String name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<User> users;

  ClassModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.users,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "users": List<dynamic>.from(users.map((x) => x.toJson())),
  };
}

class User {
  int id;
  String name;
  String email;
  String longName;
  String phoneNumber;
  dynamic profilePicture;
  dynamic emailVerifiedAt;
  String role;
  dynamic rememberToken;
  DateTime createdAt;
  DateTime updatedAt;
  int classId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.longName,
    required this.phoneNumber,
    required this.profilePicture,
    required this.emailVerifiedAt,
    required this.role,
    required this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
    required this.classId,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    longName: json["long_name"],
    phoneNumber: json["phone_number"],
    profilePicture: json["profile_picture"],
    emailVerifiedAt: json["email_verified_at"],
    role: json["role"],
    rememberToken: json["remember_token"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    classId: json["class_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "long_name": longName,
    "phone_number": phoneNumber,
    "profile_picture": profilePicture,
    "email_verified_at": emailVerifiedAt,
    "role": role,
    "remember_token": rememberToken,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "class_id": classId,
  };
}

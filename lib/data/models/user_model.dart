import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) => List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  int id;
  String name;
  String email;
  String longName;
  String phoneNumber;
  dynamic emailVerifiedAt;
  String role;
  DateTime createdAt;
  DateTime updatedAt;
  int classId;

  UsersModel({
    required this.id,
    required this.name,
    required this.email,
    required this.longName,
    required this.phoneNumber,
    required this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.classId,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    longName: json["long_name"],
    phoneNumber: json["phone_number"],
    emailVerifiedAt: json["email_verified_at"],
    role: json["role"],
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
    "email_verified_at": emailVerifiedAt,
    "role": role,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "class_id": classId,
  };
}
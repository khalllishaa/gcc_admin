import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) =>
    List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  final int id;
  final String name;
  final String email;
  final String longName;
  final String phoneNumber;
  final String? emailVerifiedAt;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? classId;
  final int? packageId;
  String? profilePicture;

  UsersModel({
    required this.id,
    required this.name,
    required this.email,
    required this.longName,
    required this.phoneNumber,
    this.emailVerifiedAt,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.classId,
    this.packageId,
    this.profilePicture,
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
        packageId: json["package_id"],
        profilePicture: json['profile_picture'],

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
        "package_id": packageId,
        "profile_picture": profilePicture,

      };
}

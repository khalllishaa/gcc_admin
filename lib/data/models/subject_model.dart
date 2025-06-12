import 'dart:convert';

List<SubjectModel> subjectModelFromJson(String str) =>
    List<SubjectModel>.from(json.decode(str).map((x) => SubjectModel.fromJson(x)));

String subjectModelToJson(List<SubjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubjectModel {
  int id;
  String name;
  // DateTime createdAt;
  // DateTime updatedAt;

  SubjectModel({
    required this.id,
    required this.name,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    id: json["id"],
    name: json["name"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
  };
}

// To parse this JSON data, do
//
//     final scheduleModels = scheduleModelsFromJson(jsonString);

import 'dart:convert';

List<ScheduleModels> scheduleModelsFromJson(String str) => List<ScheduleModels>.from(json.decode(str).map((x) => ScheduleModels.fromJson(x)));

String scheduleModelsToJson(List<ScheduleModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleModels {
  int id;
  String day;
  String time;
  String teacher;
  String subject;
  int classId;
  DateTime createdAt;
  DateTime updatedAt;

  ScheduleModels({
    required this.id,
    required this.day,
    required this.time,
    required this.teacher,
    required this.subject,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleModels.fromJson(Map<String, dynamic> json) => ScheduleModels(
    id: json["id"],
    day: json["day"],
    time: json["time"],
    teacher: json["teacher"],
    subject: json["subject"],
    classId: json["class_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": day,
    "time": time,
    "teacher": teacher,
    "subject": subject,
    "class_id": classId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

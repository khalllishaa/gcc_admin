import 'dart:convert';

List<ScheduleModels> scheduleModelsFromJson(String str) =>
    List<ScheduleModels>.from(json.decode(str).map((x) => ScheduleModels.fromJson(x)));

String scheduleModelsToJson(List<ScheduleModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ScheduleModels {
  final int id;
  final String day;
  final String startTime;
  final String endTime;
  final String teacher;
  final String subject;
  final int classId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ScheduleModels({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.teacher,
    required this.subject,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleModels.fromJson(Map<String, dynamic> json) => ScheduleModels(
    id: json["id"],
    day: json["day"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    teacher: json["teacher"],
    subject: json["subject"],
    classId: json["class_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": day,
    "start_time": startTime,
    "end_time": endTime,
    "teacher": teacher,
    "subject": subject,
    "class_id": classId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

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
  final String? teacher;
  final String? subject;
  final int classId;
  final int teacherId;
  final int subjectId;
  final DateTime createdAt;
  final DateTime updatedAt;

  ScheduleModels({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    this.teacher,
    this.subject,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
    required this.teacherId,
    required this.subjectId,
  });

  factory ScheduleModels.fromJson(Map<String, dynamic> json) => ScheduleModels(
    id: json["id"],
    day: json["day"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    teacher: json["teacher"], // bisa null
    subject: json["subject"], // bisa null
    classId: json["class_id"],
    createdAt: DateTime.parse(json["created_at"] ?? DateTime.now().toString()),
    updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now().toString()),
    teacherId: json["teacher_id"] ?? 0,
    subjectId: json["subject_id"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": day,
    "start_time": startTime,
    "end_time": endTime,
    "teacher": teacher,
    "subject": subject,
    "class_id": classId,
    "teacher_id": teacherId,
    "subject_id": subjectId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

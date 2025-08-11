// journal_model.dart
import 'dart:convert';

List<JournalModel> journalModelFromJson(String str) =>
    List<JournalModel>.from(json.decode(str).map((x) => JournalModel.fromJson(x)));

String journalModelToJson(List<JournalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JournalModel {
  final int id;
  final int classroomId;
  final int subjectId;
  final int teacherId;
  final String? filePath;
  final Classroom classroom;
  final Subject subject;
  final Teacher teacher;
  final DateTime createdAt;
  final String? description;

  JournalModel({
    required this.id,
    required this.classroomId,
    required this.subjectId,
    required this.teacherId,
    this.filePath,
    required this.classroom,
    required this.subject,
    required this.teacher,
    required this.createdAt,
    this.description,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      id: json['id'],
      classroomId: json['classroom_id'],
      subjectId: json['subject_id'],
      teacherId: json['teacher_id'],
      filePath: json['file_path'],
      classroom: Classroom.fromJson(json['classroom']),
      subject: Subject.fromJson(json['subject']),
      teacher: Teacher.fromJson(json['teacher']),
      createdAt: DateTime.parse(json['created_at']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "classroom_id": classroomId,
      "subject_id": subjectId,
      "teacher_id": teacherId,
      "file_path": filePath,
    };
  }
}

class Classroom {
  final int id;
  final String name;

  Classroom({required this.id, required this.name});

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(id: json['id'], name: json['name']);
  }
}

class Subject {
  final int id;
  final String name;

  Subject({required this.id, required this.name});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(id: json['id'], name: json['name']);
  }
}

class Teacher {
  final int id;
  final String name;

  Teacher({required this.id, required this.name});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(id: json['id'], name: json['name']);
  }
}

class CreateJournalModel {
  final int classroomId;
  final int subjectId;
  final int teacherId;
  final String? filePath; // optional

  CreateJournalModel({
    required this.classroomId,
    required this.subjectId,
    required this.teacherId,
    this.filePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'classroom_id': classroomId,
      'subject_id': subjectId,
      'teacher_id': teacherId,
      'file_path': filePath,
    };
  }
}

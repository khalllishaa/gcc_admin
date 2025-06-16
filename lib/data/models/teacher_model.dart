class TeacherModel {
  final int id;
  final String name;
  // final String status;
  final String? status;
  final int classId;
  final String createdAt;
  final String updatedAt;

  TeacherModel({
    required this.id,
    required this.name,
    required this.status,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
  });

  // factory TeacherModel.fromJson(Map<String, dynamic> json) {
  //   return TeacherModel(
  //     id: json['id'],
  //     name: json['name'],
  //     status: json['status'],
  //     classId: json['class_id'],
  //     createdAt: json['created_at'],
  //     updatedAt: json['updated_at'],
  //   );
  // }

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'] ?? '',
      status: json['status'] ?? '',
      classId: json['class_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'class_id': classId,
      'status': status,
    };
  }
}

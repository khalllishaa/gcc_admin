class TeacherModel {
  final int id;
  final String name;
  final int classId;

  TeacherModel({
    required this.id,
    required this.name,
    required this.classId,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
      classId: json['class_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'class_id': classId,
    };
  }
}

class Report {
  final int id;
  final User user;
  final Subject subject;
  final String rating;
  final String? note;
  final DateTime createdAt;

  Report({
    required this.id,
    required this.user,
    required this.subject,
    required this.rating,
    required this.note,
    required this.createdAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'],
      user: User.fromJson(json['user']),
      subject: Subject.fromJson(json['subject']),
      rating: json['rating'],
      note: json['note'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name']);
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

class AuthModel {
  final String name;
  final String password;
  final String role;
  final int classId;
  final String token;
  final String email;
  final String phoneNumber;

  AuthModel({
    required this.name,
    required this.password,
    required this.role,
    required this.classId,
    required this.token,
    required this.email,
    required this.phoneNumber,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      name: json['name'],
      password: json['password'],
      role: json['role'],
      classId: json['class_id'],
      token: json['token'],
      email: json['email'] ?? '',
      phoneNumber: json['phone_number'] ?? '', // pastikan API mengirim
    );
  }
}
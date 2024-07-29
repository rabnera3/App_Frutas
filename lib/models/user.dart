class User {
  final int? id;
  final String username;
  final String fullName;
  final String address;
  final String phoneNumber;
  final DateTime birthDate;
  final String gender;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    this.id,
    required this.username,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.birthDate,
    required this.gender,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      fullName: json['full_name'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      birthDate: DateTime.parse(json['birth_date']),
      gender: json['gender'],
      email: json['email'],
      password: json['password'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'address': address,
      'phone_number': phoneNumber,
      'birth_date': birthDate.toIso8601String(),
      'gender': gender,
      'email': email,
      'password': password,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

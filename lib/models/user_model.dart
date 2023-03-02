import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String email;
  final String username;
  final String role;
  final String token;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.role,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      role: json['role'],
      token: token,
    );
  }

  @override
  List<Object?> get props => [];
}

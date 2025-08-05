import 'package:equatable/equatable.dart';

class PasswordResetToken extends Equatable {
  final String email;
  final String token;
  final DateTime? createdAt;

  PasswordResetToken({
    required this.email,
    required this.token,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [email, token, createdAt];
}

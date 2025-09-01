import 'package:equatable/equatable.dart';

class Inquiry extends Equatable {
  final String name;
  final String email;
  final String? phone;
  final String subject;
  final String message;

  const Inquiry({
    required this.name,
    required this.email,
    this.phone,
    required this.subject,
    required this.message,
  });

  @override
  List<Object?> get props => [name, email, phone, subject, message];
}

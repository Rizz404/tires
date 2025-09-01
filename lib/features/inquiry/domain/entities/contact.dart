import 'package:equatable/equatable.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum ContactStatus { pending, replied }

class Contact extends Equatable {
  final int id;
  final User? user;
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String subject;
  final String message;
  final ContactStatus status;
  final String? adminReply;
  final DateTime? repliedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Contact({
    required this.id,
    this.user,
    this.fullName,
    this.email,
    this.phoneNumber,
    required this.subject,
    required this.message,
    required this.status,
    this.adminReply,
    this.repliedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    fullName,
    email,
    phoneNumber,
    subject,
    message,
    status,
    adminReply,
    repliedAt,
    createdAt,
    updatedAt,
  ];
}

import 'dart:convert';

import 'package:tires/features/contact/domain/entities/contact.dart';
import 'package:tires/features/user/data/models/user_model.dart';
import 'package:tires/features/user/domain/entities/user.dart';

class ContactModel extends Contact {
  const ContactModel({
    required super.id,
    super.user,
    super.fullName,
    super.email,
    super.phoneNumber,
    required super.subject,
    required super.message,
    required super.status,
    super.adminReply,
    super.repliedAt,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    // Parse user if present
    User? user;
    if (map['user'] != null) {
      user = UserModel.fromMap(map['user'] as Map<String, dynamic>);
    }

    // Parse status
    ContactStatus status;
    final statusValue = map['status'] as String;
    try {
      status = ContactStatus.values.byName(statusValue);
    } catch (e) {
      print(
        'Warning: Invalid status value "$statusValue", defaulting to pending',
      );
      status = ContactStatus.pending;
    }

    return ContactModel(
      id: map['id'] as int? ?? 0,
      user: user,
      fullName: map['full_name'] as String?,
      email: map['email'] as String?,
      phoneNumber: map['phone_number'] as String?,
      subject: map['subject'] as String? ?? '',
      message: map['message'] as String? ?? '',
      status: status,
      adminReply: map['admin_reply'] as String?,
      repliedAt: map['replied_at'] != null
          ? DateTime.parse(map['replied_at'] as String)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : DateTime.now(),
    );
  }

  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ContactModel.fromEntity(Contact entity) {
    return ContactModel(
      id: entity.id,
      user: entity.user,
      fullName: entity.fullName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      subject: entity.subject,
      message: entity.message,
      status: entity.status,
      adminReply: entity.adminReply,
      repliedAt: entity.repliedAt,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  ContactModel copyWith({
    int? id,
    User? user,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? subject,
    String? message,
    ContactStatus? status,
    String? adminReply,
    DateTime? repliedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      user: user ?? this.user,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      status: status ?? this.status,
      adminReply: adminReply ?? this.adminReply,
      repliedAt: repliedAt ?? this.repliedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user': (user as UserModel?)?.toMap(),
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'subject': subject,
      'message': message,
      'status': status.name,
      'admin_reply': adminReply,
      'replied_at': repliedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ContactModel(id: $id, user: $user, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, subject: $subject, message: $message, status: $status, adminReply: $adminReply, repliedAt: $repliedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

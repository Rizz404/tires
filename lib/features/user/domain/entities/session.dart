// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Session extends Equatable {
  final String id;
  final String? userId;
  final String? ipAddress;
  final String? userAgent;
  final String payload;
  final int lastActivity;

  Session({
    required this.id,
    required this.userId,
    required this.ipAddress,
    required this.userAgent,
    required this.payload,
    required this.lastActivity,
  });

  @override
  List<Object?> get props {
    return [id, userId, ipAddress, userAgent, payload, lastActivity];
  }
}

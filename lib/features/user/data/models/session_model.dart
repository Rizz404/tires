import 'dart:convert';

import 'package:tires/features/user/domain/entities/session.dart';

class SessionModel extends Session {
  SessionModel({
    required super.id,
    super.userId,
    super.ipAddress,
    super.userAgent,
    required super.payload,
    required super.lastActivity,
  });

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      id: map['id'] as String,
      userId: map['userId'] != null ? map['userId'] : null,
      ipAddress: map['ipAddress'] != null ? map['ipAddress'] : null,
      userAgent: map['userAgent'] != null ? map['userAgent'] : null,
      payload: map['payload'],
      lastActivity: map['lastActivity'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'ipAddress': ipAddress,
      'userAgent': userAgent,
      'payload': payload,
      'lastActivity': lastActivity,
    };
  }

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(toMap());
}

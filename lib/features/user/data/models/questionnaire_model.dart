import 'dart:convert';

import 'package:tires/features/user/data/models/reservation.dart';
import 'package:tires/features/user/domain/entities/questionnare.dart';

class QuestionnaireModel extends Questionnaire {
  const QuestionnaireModel({
    required super.id,
    required super.reservation,
    required super.questionsAndAnswers,
    required super.createdAt,
    required super.updatedAt,
  });

  QuestionnaireModel copyWith({
    int? id,
    ReservationModel? reservation,
    Map<String, dynamic>? questionsAndAnswers,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return QuestionnaireModel(
      id: id ?? this.id,
      reservation: reservation ?? this.reservation,
      questionsAndAnswers: questionsAndAnswers ?? this.questionsAndAnswers,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservation': (reservation as ReservationModel).toMap(),
      'questionsAndAnswers': questionsAndAnswers,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory QuestionnaireModel.fromMap(Map<String, dynamic> map) {
    return QuestionnaireModel(
      id: map['id']?.toInt() ?? 0,
      reservation: ReservationModel.fromMap(map['reservation']),
      questionsAndAnswers: Map<String, dynamic>.from(
        map['questionsAndAnswers'],
      ),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  factory QuestionnaireModel.fromEntity(Questionnaire entity) {
    return QuestionnaireModel(
      id: entity.id,
      reservation: entity.reservation,
      questionsAndAnswers: entity.questionsAndAnswers,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionnaireModel.fromJson(String source) =>
      QuestionnaireModel.fromMap(json.decode(source));

  @override
  String toString() => 'QuestionnaireModel(${toMap()})';
}

import 'package:equatable/equatable.dart';
import 'package:tires/features/user/domain/entities/reservation.dart';

class Questionnaire extends Equatable {
  final int id;
  final Reservation reservation;
  final Map<String, dynamic> questionsAndAnswers;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Questionnaire({
    required this.id,
    required this.reservation,
    required this.questionsAndAnswers,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    reservation,
    questionsAndAnswers,
    createdAt,
    updatedAt,
  ];
}

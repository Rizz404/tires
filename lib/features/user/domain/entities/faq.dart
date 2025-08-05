import 'package:equatable/equatable.dart';

class Faq extends Equatable {
  final int id;
  final String question;
  final String answer;
  final int displayOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Faq({
    required this.id,
    required this.question,
    required this.answer,
    required this.displayOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    question,
    answer,
    displayOrder,
    isActive,
    createdAt,
    updatedAt,
  ];
}

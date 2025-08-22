import 'package:equatable/equatable.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum PaymentStatus { pending, completed, failed, refunded }

class Payment extends Equatable {
  final int id;
  final User user;
  final Reservation? reservation;
  final double amount;
  final String paymentMethod;
  final PaymentStatus status;
  final String? transactionId;
  final Map<String, dynamic>? paymentDetails;
  final DateTime? paidAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Payment({
    required this.id,
    required this.user,
    this.reservation,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    this.transactionId,
    this.paymentDetails,
    this.paidAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    user,
    reservation,
    amount,
    paymentMethod,
    status,
    transactionId,
    paymentDetails,
    paidAt,
    createdAt,
    updatedAt,
  ];
}

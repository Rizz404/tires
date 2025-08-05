import 'package:equatable/equatable.dart';
import 'package:tires/features/user/domain/entities/menu.dart';
import 'package:tires/features/user/domain/entities/user.dart';

enum ReservationStatus { pending, confirmed, completed, cancelled }

class Reservation extends Equatable {
  final int id;
  final String reservationNumber;
  final User? user;
  final String? fullName;
  final String? fullNameKana;
  final String? email;
  final String? phoneNumber;
  final Menu menu;
  final DateTime reservationDatetime;
  final int numberOfPeople;
  final double amount;
  final ReservationStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Reservation({
    required this.id,
    required this.reservationNumber,
    this.user,
    this.fullName,
    this.fullNameKana,
    this.email,
    this.phoneNumber,
    required this.menu,
    required this.reservationDatetime,
    required this.numberOfPeople,
    required this.amount,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    reservationNumber,
    user,
    fullName,
    fullNameKana,
    email,
    phoneNumber,
    menu,
    reservationDatetime,
    numberOfPeople,
    amount,
    status,
    notes,
    createdAt,
    updatedAt,
  ];
}

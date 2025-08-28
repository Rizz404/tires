import 'package:equatable/equatable.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/features/reservation/domain/entities/reservation_amount.dart';
import 'package:tires/features/reservation/domain/entities/reservation_customer_info.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';
import 'package:tires/features/reservation/domain/entities/reservation_user.dart';

class Reservation extends Equatable {
  final int id;
  final String reservationNumber;
  final ReservationUser? user;
  final ReservationCustomerInfo customerInfo;
  final Menu menu;
  final DateTime reservationDatetime;
  final int numberOfPeople;
  final ReservationAmount amount;
  final ReservationStatus status;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Reservation({
    required this.id,
    required this.reservationNumber,
    this.user,
    required this.customerInfo,
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
    customerInfo,
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

import 'package:equatable/equatable.dart';

class ReservationCustomerInfo extends Equatable {
  final String fullName;
  final String fullNameKana;
  final String email;
  final String phoneNumber;
  final bool isGuest;

  const ReservationCustomerInfo({
    required this.fullName,
    required this.fullNameKana,
    required this.email,
    required this.phoneNumber,
    required this.isGuest,
  });

  @override
  List<Object?> get props => [
    fullName,
    fullNameKana,
    email,
    phoneNumber,
    isGuest,
  ];
}

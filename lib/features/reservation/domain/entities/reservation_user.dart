import 'package:equatable/equatable.dart';

class ReservationUser extends Equatable {
  final int id;
  final String fullName;
  final String email;
  final String phoneNumber;

  const ReservationUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
  });

  @override
  List<Object?> get props => [id, fullName, email, phoneNumber];
}

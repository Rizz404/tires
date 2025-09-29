import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/entities/reservation_status.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class UpdateReservationUsecase
    implements
        Usecase<ItemSuccessResponse<Reservation>, UpdateReservationParams> {
  final ReservationRepository _reservationRepository;

  UpdateReservationUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> call(
    UpdateReservationParams params,
  ) async {
    AppLogger.businessInfo('Executing update reservation usecase');
    return await _reservationRepository.updateReservation(params);
  }
}

class UpdateReservationParams extends Equatable {
  final int id;
  final String? reservationNumber;
  final int? userId;
  final int menuId;
  final DateTime reservationDatetime;
  final int numberOfPeople;
  final int amount;
  final ReservationStatusValue? status;
  final String? notes;
  // final String customerType;
  // final String fullName;
  // final String fullNameKana;
  // final String email;
  // final String phoneNumber;

  const UpdateReservationParams({
    required this.id,
    this.reservationNumber,
    this.userId,
    required this.menuId,
    required this.reservationDatetime,
    required this.numberOfPeople,
    required this.amount,
    this.status,
    this.notes,
  });

  @override
  List<Object?> get props {
    return [
      id,
      reservationNumber,
      userId,
      menuId,
      reservationDatetime,
      numberOfPeople,
      amount,
      status,
      notes,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'reservation_number': reservationNumber,
      'user_id': userId,
      'menu_id': menuId,
      'reservation_datetime': reservationDatetime.millisecondsSinceEpoch,
      'number_of_people': numberOfPeople,
      'amount': amount,
      'status': status?.name,
      'notes': notes,
    };
  }

  String toJson() => json.encode(toMap());

  factory UpdateReservationParams.fromMap(Map<String, dynamic> map) {
    return UpdateReservationParams(
      id: map['id']?.toInt() ?? 0,
      reservationNumber: map['reservation_number'],
      userId: map['user_id']?.toInt(),
      menuId: map['menu_id']?.toInt() ?? 0,
      reservationDatetime: DateTime.fromMillisecondsSinceEpoch(
        map['reservation_datetime'],
      ),
      numberOfPeople: map['number_of_people']?.toInt() ?? 0,
      amount: map['amount']?.toInt() ?? 0,
      status: map['status'] != null
          ? ReservationStatusValue.values.byName(map['status'])
          : null,
      notes: map['notes'],
    );
  }

  factory UpdateReservationParams.fromJson(String source) =>
      UpdateReservationParams.fromMap(json.decode(source));
}

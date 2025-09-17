// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:intl/intl.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class CreateReservationUsecase
    implements
        Usecase<ItemSuccessResponse<Reservation>, CreateReservationParams> {
  final ReservationRepository _reservationRepository;

  CreateReservationUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<Reservation>>> call(
    CreateReservationParams params,
  ) async {
    AppLogger.businessInfo('Executing create reservation usecase');
    return await _reservationRepository.createReservation(params);
  }
}

class CreateReservationParams extends Equatable {
  final int menuId;
  final DateTime reservationDatetime;
  final int numberOfPeople;
  final int amount;

  const CreateReservationParams({
    required this.menuId,
    required this.reservationDatetime,
    this.numberOfPeople = 1,
    required this.amount,
  });

  @override
  List<Object> get props => [
    menuId,
    reservationDatetime,
    numberOfPeople,
    amount,
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'menu_id': menuId,
      'reservation_datetime': DateFormat(
        'yyyy-MM-dd HH:mm:ss',
      ).format(reservationDatetime),
      'number_of_people': numberOfPeople,
      'amount': amount,
    };
  }

  String toJson() => json.encode(toMap());
}

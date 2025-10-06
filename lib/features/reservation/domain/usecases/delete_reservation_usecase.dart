import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class DeleteReservationUsecase
    implements Usecase<ActionSuccess, DeleteReservationParams> {
  final ReservationRepository _reservationRepository;

  DeleteReservationUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, ActionSuccess>> call(
    DeleteReservationParams params,
  ) async {
    AppLogger.businessInfo('Executing delete reservation usecase');
    return await _reservationRepository.deleteReservation(params);
  }
}

class DeleteReservationParams extends Equatable {
  final int id;

  const DeleteReservationParams({required this.id});

  @override
  List<Object?> get props => [id];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }

  String toJson() => json.encode(toMap());
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';

import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class GetReservationCursorUsecase
    implements
        Usecase<
          CursorPaginatedSuccess<Reservation>,
          GetReservationCursorParams
        > {
  final ReservationRepository _reservationRepository;

  GetReservationCursorUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>> call(
    GetReservationCursorParams params,
  ) async {
    AppLogger.businessInfo('Executing get reservation cursor usecase');
    return await _reservationRepository.getReservationsCursor(params);
  }
}

class GetReservationCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;

  const GetReservationCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  @override
  List<Object?> get props => [paginate, perPage, cursor];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate.toString(),
      'per_page': perPage.toString(),
      if (cursor != null) 'cursor': cursor,
    };
  }

  String toJson() => json.encode(toMap());
}

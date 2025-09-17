import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/reservation/domain/repositories/reservation_repository.dart';

class GetCurrentUserReservationsCursorUsecase
    implements
        Usecase<
          CursorPaginatedSuccess<Reservation>,
          GetCurrentUserReservationsCursorParams
        > {
  final ReservationRepository _reservationRepository;

  GetCurrentUserReservationsCursorUsecase(this._reservationRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>> call(
    GetCurrentUserReservationsCursorParams params,
  ) async {
    AppLogger.businessInfo(
      'Executing get current user reservations cursor usecase',
    );
    return await _reservationRepository.getCurrentUserReservations(params);
  }
}

class GetCurrentUserReservationsCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;

  const GetCurrentUserReservationsCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  @override
  List<Object?> get props => [paginate, perPage, cursor];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'paginate': paginate,
      'per_page': perPage,
      if (cursor != null) 'cursor': cursor,
    };
  }
}

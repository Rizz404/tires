import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/reservation/domain/entities/reservation.dart';
import 'package:tires/features/user/domain/repositories/current_user_repository.dart';

class GetCurrentUserReservationsCursorUsecase
    implements
        Usecase<
          CursorPaginatedSuccess<Reservation>,
          GetUserReservationsCursorParams
        > {
  final CurrentUserRepository _userRepository;

  GetCurrentUserReservationsCursorUsecase(this._userRepository);

  @override
  Future<Either<Failure, CursorPaginatedSuccess<Reservation>>> call(
    GetUserReservationsCursorParams params,
  ) async {
    return await _userRepository.getCurrentUserReservations(
      paginate: params.paginate,
      perPage: params.perPage,
      cursor: params.cursor,
    );
  }
}

class GetUserReservationsCursorParams extends Equatable {
  final bool paginate;
  final int perPage;
  final String? cursor;

  const GetUserReservationsCursorParams({
    required this.paginate,
    required this.perPage,
    this.cursor,
  });

  @override
  List<Object?> get props => [paginate, perPage, cursor];
}

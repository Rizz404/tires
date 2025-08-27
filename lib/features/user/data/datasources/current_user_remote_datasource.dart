import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';
import 'package:tires/features/user/data/models/user_model.dart';

abstract class CurrentUserRemoteDatasource {
  Future<Either<Failure, ItemSuccessResponse<UserModel>>> getCurrentUser();
  Future<Either<Failure, ItemSuccessResponse<UserModel>>> updateCurrentUser({
    required String fullName,
    required String fullNameKana,
    required String email,
    required String phoneNumber,
    String? companyName,
    String? department,
    String? companyAddress,
    String? homeAddress,
    DateTime? dateOfBirth,
    String? gender,
  });
  Future<Either<Failure, ActionSuccess>> updateCurrentUserPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<ApiCursorPaginationResponse<ReservationModel>>
  getCurrentUserReservations({
    required bool paginate,
    required int perPage,
    String? cursor,
  });
  Future<Either<Failure, ActionSuccess>> deleteCurrentUserAccount();
}

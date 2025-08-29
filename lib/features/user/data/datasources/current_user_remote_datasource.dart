import 'package:tires/core/network/api_cursor_pagination_response.dart';
import 'package:tires/core/network/api_response.dart';
import 'package:tires/features/customer_management/data/models/customer_dashboard_model.dart';
import 'package:tires/features/reservation/data/models/reservation_model.dart';
import 'package:tires/features/user/data/models/user_model.dart';

abstract class CurrentUserRemoteDatasource {
  Future<ApiResponse<UserModel>> getCurrentUser();
  Future<ApiResponse<UserModel>> updateCurrentUser({
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
  Future<ApiResponse<dynamic>> updateCurrentUserPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  });
  Future<ApiResponse<CustomerDashboardModel>> getCurrentUserDashboard();
  Future<ApiCursorPaginationResponse<ReservationModel>>
  getCurrentUserReservations({
    required bool paginate,
    required int perPage,
    String? cursor,
  });
  Future<ApiResponse<dynamic>> deleteCurrentUserAccount();
}

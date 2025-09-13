import 'package:tires/core/network/api_response.dart';
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
  Future<ApiResponse<dynamic>> deleteCurrentUserAccount();
}

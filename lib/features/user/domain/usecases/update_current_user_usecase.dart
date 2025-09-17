import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/domain/repositories/current_user_repository.dart';

class UpdateCurrentUserUsecase
    implements Usecase<ItemSuccessResponse<User>, UpdateUserParams> {
  final CurrentUserRepository _userRepository;

  UpdateCurrentUserUsecase(this._userRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<User>>> call(
    UpdateUserParams params,
  ) async {
    AppLogger.businessInfo('Executing update current user usecase');
    final result = await _userRepository.updateCurrentUser(
      fullName: params.fullName,
      fullNameKana: params.fullNameKana,
      email: params.email,
      phoneNumber: params.phoneNumber,
      companyName: params.companyName,
      department: params.department,
      companyAddress: params.companyAddress,
      homeAddress: params.homeAddress,
      dateOfBirth: params.dateOfBirth,
      gender: params.gender,
    );
    result.fold(
      (failure) => AppLogger.businessError(
        'Update current user usecase failed',
        failure,
      ),
      (success) => AppLogger.businessInfo(
        'Update current user usecase completed successfully',
      ),
    );
    return result;
  }
}

class UpdateUserParams extends Equatable {
  final String fullName;
  final String fullNameKana;
  final String email;
  final String phoneNumber;
  final String? companyName;
  final String? department;
  final String? companyAddress;
  final String? homeAddress;
  final DateTime? dateOfBirth;
  final String? gender;

  const UpdateUserParams({
    required this.fullName,
    required this.fullNameKana,
    required this.email,
    required this.phoneNumber,
    this.companyName,
    this.department,
    this.companyAddress,
    this.homeAddress,
    this.dateOfBirth,
    this.gender,
  });

  @override
  List<Object?> get props => [
    fullName,
    fullNameKana,
    email,
    phoneNumber,
    companyName,
    department,
    companyAddress,
    homeAddress,
    dateOfBirth,
    gender,
  ];
}

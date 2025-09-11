import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/features/dashboard/domain/entities/dashboard.dart';

abstract class DashboardRepository {
  Future<Either<Failure, ItemSuccessResponse<Dashboard>>> getDashboard();
}

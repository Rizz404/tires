import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/availability/domain/entities/availability_date.dart';
import 'package:tires/features/availability/domain/repositories/availability_repository.dart';

class GetReservationAvailabilityUsecase
    implements
        Usecase<
          ItemSuccessResponse<List<AvailabilityDate>>,
          GetReservationAvailabilityParams
        > {
  final AvailabilityRepository _availabilityRepository;

  GetReservationAvailabilityUsecase(this._availabilityRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<List<AvailabilityDate>>>> call(
    GetReservationAvailabilityParams params,
  ) async {
    return await _availabilityRepository.getReservationAvailability(params);
  }
}

class GetReservationAvailabilityParams extends Equatable {
  final int menuId;
  final DateTime startDate; // * Formatnya begini Y-m-d
  final DateTime endDate; // * Formatnya begini Y-m-d
  final int? excludeReservationId;

  const GetReservationAvailabilityParams({
    required this.menuId,
    required this.startDate,
    required this.endDate,
    this.excludeReservationId,
  });

  GetReservationAvailabilityParams copyWith({
    int? menuId,
    DateTime? startDate,
    DateTime? endDate,
    int? excludeReservationId,
  }) {
    return GetReservationAvailabilityParams(
      menuId: menuId ?? this.menuId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      excludeReservationId: excludeReservationId ?? this.excludeReservationId,
    );
  }

  Map<String, dynamic> toMap() {
    // Format dates as Y-m-d (YYYY-MM-DD) as required by the server
    String formatDate(DateTime date) {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    return <String, dynamic>{
      'menu_id': menuId,
      'start_date': formatDate(startDate),
      'end_date': formatDate(endDate),
      'exclude_reservation_id': excludeReservationId,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [menuId, startDate, endDate, excludeReservationId];
  }

  factory GetReservationAvailabilityParams.fromMap(Map<String, dynamic> map) {
    return GetReservationAvailabilityParams(
      menuId: map['menu_id'] as int,
      startDate: DateTime.parse(map['start_date'] as String),
      endDate: DateTime.parse(map['end_date'] as String),
      excludeReservationId: map['exclude_reservation_id'] as int?,
    );
  }

  factory GetReservationAvailabilityParams.fromJson(String source) =>
      GetReservationAvailabilityParams.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

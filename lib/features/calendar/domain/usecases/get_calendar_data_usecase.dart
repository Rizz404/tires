import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tires/core/domain/domain_response.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/core/usecases/usecase.dart';
import 'package:tires/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:tires/features/calendar/domain/entities/calendar_data.dart';

class GetCalendarDataUsecase
    implements
        Usecase<ItemSuccessResponse<CalendarData>, GetCalendarDataParams> {
  final CalendarRepository _calendarRepository;

  GetCalendarDataUsecase(this._calendarRepository);

  @override
  Future<Either<Failure, ItemSuccessResponse<CalendarData>>> call(
    GetCalendarDataParams params,
  ) async {
    AppLogger.businessInfo('Executing get calendar data usecase');
    return await _calendarRepository.getCalendarData(params);
  }
}

enum GetCalendarDataParamsStatus { pending, confirmed, completed, cancelled }

enum GetCalendarDataParamsView { month, week, day }

class GetCalendarDataParams extends Equatable {
  final int? menuId;
  final DateTime? month;
  final GetCalendarDataParamsStatus? status;
  final GetCalendarDataParamsView? view;

  const GetCalendarDataParams({
    this.menuId,
    this.month,
    this.status,
    this.view,
  });

  GetCalendarDataParams copyWith({
    int? menuId,
    DateTime? month,
    GetCalendarDataParamsStatus? status,
    GetCalendarDataParamsView? view,
  }) {
    return GetCalendarDataParams(
      menuId: menuId ?? this.menuId,
      month: month ?? this.month,
      status: status ?? this.status,
      view: view ?? this.view,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (menuId != null) 'menu_id': menuId,
      if (month != null)
        'month': '${month!.year}-${month!.month.toString().padLeft(2, '0')}',
      if (status != null) 'status': status!.name,
      if (view != null) 'view': view!.name,
    };
  }

  factory GetCalendarDataParams.fromMap(Map<String, dynamic> map) {
    return GetCalendarDataParams(
      menuId: map['menu_id'] != null ? map['menu_id'] as int : null,
      month: map['month'] != null
          ? _parseMonthString(map['month'] as String)
          : null,
      status: map['status'] != null
          ? GetCalendarDataParamsStatus.values.firstWhere(
              (e) => e.name == map['status'],
              orElse: () => GetCalendarDataParamsStatus.pending,
            )
          : null,
      view: map['view'] != null
          ? GetCalendarDataParamsView.values.firstWhere(
              (e) => e.name == map['view'],
              orElse: () => GetCalendarDataParamsView.month,
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory GetCalendarDataParams.fromJson(String source) =>
      GetCalendarDataParams.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [menuId, month, status, view];

  static DateTime? _parseMonthString(String monthString) {
    try {
      final parts = monthString.split('-');
      if (parts.length == 2) {
        final year = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        return DateTime(year, month, 1);
      }
      // Fallback to full DateTime parsing if it's not Y-m format
      return DateTime.parse(monthString);
    } catch (e) {
      return null;
    }
  }
}

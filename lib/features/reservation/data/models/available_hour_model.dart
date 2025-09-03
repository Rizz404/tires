import 'dart:convert';

import 'package:tires/features/reservation/domain/entities/available_hour.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

class AvailableHourModel extends AvailableHour {
  AvailableHourModel({required super.hours});

  AvailableHourModel copyWith({List<HourModel>? hours}) {
    return AvailableHourModel(hours: hours ?? this.hours);
  }

  Map<String, dynamic> toMap() {
    return {
      'hours': (hours as List<HourModel>).map((hour) => hour.toMap()).toList(),
    };
  }

  factory AvailableHourModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('AvailableHourModel', map);

    final hoursData =
        DebugHelper.safeCast<List>(
          map['hours'],
          'hours',
          defaultValue: <dynamic>[],
        ) ??
        <dynamic>[];

    return AvailableHourModel(
      hours: hoursData
          .map((hour) => HourModel.fromMap(hour as Map<String, dynamic>))
          .toList(),
    );
  }

  factory AvailableHourModel.fromEntity(AvailableHour entity) {
    return AvailableHourModel(
      hours: entity.hours.map((hour) => HourModel.fromEntity(hour)).toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AvailableHourModel.fromJson(String source) =>
      AvailableHourModel.fromMap(json.decode(source));

  @override
  String toString() => 'AvailableHourModel(${toMap()})';
}

class HourModel extends Hour {
  HourModel({
    required super.time,
    required super.datetime,
    required super.status,
    required super.available,
    required super.indicator,
  });

  HourModel copyWith({
    String? time,
    DateTime? datetime,
    Status? status,
    bool? available,
    Indicator? indicator,
  }) {
    return HourModel(
      time: time ?? this.time,
      datetime: datetime ?? this.datetime,
      status: status ?? this.status,
      available: available ?? this.available,
      indicator: indicator ?? this.indicator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'datetime': datetime.toIso8601String(),
      'status': _statusToString(status),
      'available': available,
      'indicator': _indicatorToString(indicator),
    };
  }

  factory HourModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('HourModel', map);

    final timeValue =
        DebugHelper.safeCast<String>(map['time'], 'time', defaultValue: '') ??
        '';

    final datetimeValue =
        DebugHelper.safeParseDateTime(map['datetime'], 'datetime') ??
        DateTime.now();

    final statusString =
        DebugHelper.safeCast<String>(
          map['status'],
          'status',
          defaultValue: 'available',
        ) ??
        'available';

    final availableValue =
        DebugHelper.safeCast<bool>(
          map['available'],
          'available',
          defaultValue: false,
        ) ??
        false;

    final indicatorString =
        DebugHelper.safeCast<String>(
          map['indicator'],
          'indicator',
          defaultValue: 'Empty',
        ) ??
        'Empty';

    return HourModel(
      time: timeValue,
      datetime: datetimeValue,
      status: _parseStatus(statusString),
      available: availableValue,
      indicator: _parseIndicator(indicatorString),
    );
  }

  factory HourModel.fromEntity(Hour entity) {
    return HourModel(
      time: entity.time,
      datetime: entity.datetime,
      status: entity.status,
      available: entity.available,
      indicator: entity.indicator,
    );
  }

  String toJson() => json.encode(toMap());

  factory HourModel.fromJson(String source) =>
      HourModel.fromMap(json.decode(source));

  @override
  String toString() => 'HourModel(${toMap()})';

  static Status _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return Status.available;
      case 'reserved':
        return Status.reserved;
      default:
        return Status.available;
    }
  }

  static String _statusToString(Status status) {
    switch (status) {
      case Status.available:
        return 'available';
      case Status.reserved:
        return 'reserved';
    }
  }

  static Indicator _parseIndicator(String indicator) {
    switch (indicator) {
      case 'Empty':
        return Indicator.Empty;
      case 'Reserved':
        return Indicator.Reserved;
      default:
        return Indicator.Empty;
    }
  }

  static String _indicatorToString(Indicator indicator) {
    switch (indicator) {
      case Indicator.Empty:
        return 'Empty';
      case Indicator.Reserved:
        return 'Reserved';
    }
  }
}

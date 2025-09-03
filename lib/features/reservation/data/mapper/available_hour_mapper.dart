import 'package:tires/features/reservation/data/models/available_hour_model.dart';
import 'package:tires/features/reservation/domain/entities/available_hour.dart';

// AvailableHour mappers
extension AvailableHourModelMapper on AvailableHourModel {
  AvailableHour toEntity() {
    return AvailableHour(
      hours: (hours as List<HourModel>).map((hour) => hour.toEntity()).toList(),
    );
  }
}

extension AvailableHourEntityMapper on AvailableHour {
  AvailableHourModel toModel() {
    return AvailableHourModel.fromEntity(this);
  }
}

// Hour mappers
extension HourModelMapper on HourModel {
  Hour toEntity() {
    return Hour(
      time: time,
      datetime: datetime,
      status: status,
      available: available,
      indicator: indicator,
    );
  }
}

extension HourEntityMapper on Hour {
  HourModel toModel() {
    return HourModel.fromEntity(this);
  }
}

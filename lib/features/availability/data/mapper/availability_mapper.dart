import 'package:tires/core/network/api_response.dart';
import 'package:tires/features/availability/data/models/availability_calendar_model.dart';
import 'package:tires/features/availability/domain/entities/availability_calendar.dart';

class AvailabilityMapper {
  static AvailabilityCalendar mapApiResponseToEntity(
    ApiResponse<Map<String, dynamic>> apiResponse,
  ) {
    final model = AvailabilityCalendarModel.fromMap(apiResponse.data);
    return model.toEntity();
  }

  static AvailabilityCalendar mapModelToEntity(
    AvailabilityCalendarModel model,
  ) {
    return model.toEntity();
  }
}

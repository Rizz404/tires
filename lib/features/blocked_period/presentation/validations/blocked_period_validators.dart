import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class BlockedPeriodValidators {
  static FormFieldValidator<String> reasonEn(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'English reason is required'),
      FormBuilderValidators.maxLength(
        500,
        errorText: 'Reason must be less than 500 characters',
      ),
    ]);
  }

  static FormFieldValidator<String> reasonJa(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.maxLength(
        500,
        errorText: 'Reason must be less than 500 characters',
      ),
    ]);
  }

  static FormFieldValidator<DateTime> startDate(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'Start date is required'),
      (value) {
        if (value == null) return null;
        final now = DateTime.now();
        if (value.isBefore(DateTime(now.year, now.month, now.day))) {
          return 'Start date cannot be in the past';
        }
        return null;
      },
    ]);
  }

  static FormFieldValidator<DateTime> endDate(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'End date is required'),
    ]);
  }

  static FormFieldValidator<DateTime> startTime(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'Start time is required'),
    ]);
  }

  static FormFieldValidator<DateTime> endTime(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'End time is required'),
    ]);
  }

  static String? validateDateTimeRange({
    required DateTime? startDate,
    required DateTime? endDate,
    required DateTime? startTime,
    required DateTime? endTime,
  }) {
    if (startDate == null || endDate == null || startTime == null || endTime == null) {
      return null; // Individual field validations will handle null cases
    }

    final startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );

    final endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );

    if (endDateTime.isBefore(startDateTime) || endDateTime.isAtSameMomentAs(startDateTime)) {
      return 'End date/time must be after start date/time';
    }

    // Check if the duration is reasonable (not more than 1 year)
    final duration = endDateTime.difference(startDateTime);
    if (duration.inDays > 365) {
      return 'Blocked period cannot exceed 1 year';
    }

    return null;
  }
}

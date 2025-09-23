import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class MenuValidators {
  static FormFieldValidator<String> nameEn(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'English name is required'),
      FormBuilderValidators.maxLength(
        255,
        errorText: 'Name must be less than 255 characters',
      ),
    ]);
  }

  static FormFieldValidator<String> nameJa(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.maxLength(
        255,
        errorText: 'Name must be less than 255 characters',
      ),
    ]);
  }

  static FormFieldValidator<String> descriptionEn(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: 'English description is required',
      ),
      FormBuilderValidators.maxLength(
        1000,
        errorText: 'Description must be less than 1000 characters',
      ),
    ]);
  }

  static FormFieldValidator<String> descriptionJa(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.maxLength(
        1000,
        errorText: 'Description must be less than 1000 characters',
      ),
    ]);
  }

  static FormFieldValidator<String> requiredTime(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'Required time is required'),
      (value) {
        if (value == null || value.isEmpty) return null;

        final parsedValue = int.tryParse(value);

        if (parsedValue == null) {
          return 'Required time must be a valid number';
        }

        if (parsedValue < 1) {
          return 'Required time must be at least 1 minute';
        }

        if (parsedValue > 1440) {
          // 24 hours in minutes
          return 'Required time must be less than 24 hours';
        }

        return null;
      },
    ]);
  }

  static FormFieldValidator<String> price(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'Price is required'),
      (value) {
        if (value == null || value.isEmpty) return null;

        // Remove commas and other formatting for validation
        final cleanValue = value.replaceAll(RegExp(r'[,¥$\s]'), '');
        final parsedValue = int.tryParse(cleanValue);

        if (parsedValue == null) {
          return 'Price must be a valid number';
        }

        if (parsedValue < 0) {
          return 'Price must be at least 0';
        }

        if (parsedValue > 999999999) {
          return 'Price must be less than 999,999,999';
        }

        return null;
      },
    ]);
  }

  static FormFieldValidator<String> displayOrder(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'Display order is required'),
      (value) {
        if (value == null || value.isEmpty) return null;

        final parsedValue = int.tryParse(value);

        if (parsedValue == null) {
          return 'Display order must be a valid number';
        }

        if (parsedValue < 0) {
          return 'Display order must be at least 0';
        }

        return null;
      },
    ]);
  }
}

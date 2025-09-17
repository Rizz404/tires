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
      FormBuilderValidators.min(
        1,
        errorText: 'Required time must be at least 1 minute',
      ),
      FormBuilderValidators.max(
        1440, // 24 hours in minutes
        errorText: 'Required time must be less than 24 hours',
      ),
    ]);
  }

  static FormFieldValidator<String> price(BuildContext context) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'Price is required'),
      FormBuilderValidators.min(0, errorText: 'Price must be at least 0'),
      FormBuilderValidators.max(
        999999,
        errorText: 'Price must be less than 999,999',
      ),
    ]);
  }
}

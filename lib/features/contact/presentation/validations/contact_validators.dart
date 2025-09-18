import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/extensions/localization_extensions.dart';

class ContactValidators {
  static FormFieldValidator<String> subject(BuildContext context) {
    final l10n = context.l10n;
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: l10n.adminUpsertContactScreenRequiredField,
      ),
      FormBuilderValidators.maxLength(
        255,
        errorText: l10n.adminUpsertContactScreenMaxCharacters,
      ),
    ]);
  }

  static FormFieldValidator<String> message(BuildContext context) {
    final l10n = context.l10n;
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: l10n.adminUpsertContactScreenRequiredField,
      ),
    ]);
  }

  static FormFieldValidator<String> fullName(BuildContext context) {
    final l10n = context.l10n;
    return FormBuilderValidators.compose([
      FormBuilderValidators.maxLength(
        255,
        errorText: l10n.adminUpsertContactScreenMaxCharacters,
      ),
    ]);
  }

  static FormFieldValidator<String> email(BuildContext context) {
    final l10n = context.l10n;
    return FormBuilderValidators.compose([
      FormBuilderValidators.email(
        errorText: l10n.adminUpsertContactScreenInvalidEmail,
      ),
    ]);
  }

  static FormFieldValidator<String> phoneNumber(BuildContext context) {
    final l10n = context.l10n;
    return FormBuilderValidators.compose([
      FormBuilderValidators.maxLength(
        20,
        errorText: l10n.adminUpsertContactScreenMaxCharacters,
      ),
    ]);
  }
}

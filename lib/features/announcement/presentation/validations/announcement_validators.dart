import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/extensions/localization_extensions.dart';

class AnnouncementValidators {
  static FormFieldValidator<String> title(BuildContext context) {
    final l10n = context.l10n;
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: l10n.adminUpsertAnnouncementScreenRequiredField,
      ),
      FormBuilderValidators.maxLength(
        255,
        errorText: l10n.adminUpsertAnnouncementScreenMaxCharacters,
      ),
    ]);
  }

  static FormFieldValidator<String> content(BuildContext context) {
    final l10n = context.l10n;
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: l10n.adminUpsertAnnouncementScreenRequiredField,
      ),
    ]);
  }
}

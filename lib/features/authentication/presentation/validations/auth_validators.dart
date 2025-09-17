import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/services/app_logger.dart';

class AuthValidators {
  static final email = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Email is required.'),
    FormBuilderValidators.email(errorText: 'The email format is not valid.'),
  ]);

  static final password = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Password is required.'),
    FormBuilderValidators.minLength(
      8,
      errorText: 'Password must be at least 8 characters.',
    ),
  ]);

  static final fullName = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Full name is required.'),
  ]);

  static final fullNameKana = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Full name (Kana) is required.'),
  ]);

  static final phoneNumber = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Phone number is required.'),
    FormBuilderValidators.numeric(
      errorText: 'Phone number must contain only digits.',
    ),
  ]);

  static final dateOfBirth = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Date of birth is required.'),
  ]);

  static final gender = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'Please select a gender.'),
  ]);

  static final termsAgreement = FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    (value) {
      if (value != true) {
        return 'You must agree to the terms and conditions.';
      }
      return null;
    },
  ]);

  static String? Function(String?) confirmPassword(String passwordToMatch) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(
        errorText: 'Please confirm your password.',
      ),
      (value) {
        if (value != passwordToMatch) {
          return 'Passwords do not match.';
        }
        return null;
      },
    ]);
  }
}

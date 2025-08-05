import 'package:form_builder_validators/form_builder_validators.dart';

class AuthValidators {
  static final email = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'This field cannot be empty.'),
    FormBuilderValidators.email(errorText: 'The email format is not valid.'),
  ]);

  static final password = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'This field cannot be empty.'),
    FormBuilderValidators.minLength(
      8,
      errorText: 'Password must be at least 8 characters long.',
    ),
  ]);

  static final username = FormBuilderValidators.compose([
    FormBuilderValidators.required(errorText: 'This field cannot be empty.'),
    FormBuilderValidators.minLength(
      4,
      errorText: 'Username must be at least 4 characters long.',
    ),
  ]);

  static String? Function(String?) confirmPassword(String passwordToMatch) {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(errorText: 'This field cannot be empty.'),
      FormBuilderValidators.equal(
        passwordToMatch,
        errorText: 'Passwords do not match.',
      ),
    ]);
  }
}

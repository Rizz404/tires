import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:faker/faker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
import 'package:tires/features/authentication/presentation/providers/auth_providers.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';
import 'package:tires/features/authentication/presentation/validations/auth_validators.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_checkbox.dart';
import 'package:tires/shared/presentation/widgets/app_date_time_picker.dart';
import 'package:tires/shared/presentation/widgets/app_radio_group.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;

  late final Map<String, dynamic> _initialValues;

  @override
  void initState() {
    super.initState();
    final faker = Faker();
    final password = faker.internet.password(length: 10);
    final genderOptions = [
      UserGender.male,
      UserGender.female,
      UserGender.other,
    ];

    _initialValues = {
      'fullName': faker.person.name(),
      'fullNameKana': faker.person.name(),
      'email': faker.internet.email(),
      'phoneNumber': faker.phoneNumber.us().replaceAll(RegExp(r'\D'), ''),
      'companyName': faker.company.name(),
      'department': faker.company.position(),
      'password': password,
      'confirmPassword': password,
      'gender': genderOptions[Random().nextInt(genderOptions.length)],
      'dateOfBirth': faker.date.dateTime(minYear: 1980, maxYear: 2005),
      'homeAddress': faker.address.streetAddress(),
      'companyAddress': faker.address.streetAddress(),
      'terms': true,
    };
  }

  void _handleSubmit(WidgetRef ref) {
    setState(() {
      _validationErrors = null;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final params = RegisterParams(
        fullName: values['fullName'],
        fullNameKana: values['fullNameKana'],
        email: values['email'],
        phoneNumber: values['phoneNumber'],
        companyName: values['companyName'],
        department: values['department'],
        password: values['password'],
        gender: values['gender'],
        dateOfBirth: values['dateOfBirth'],
        homeAddress: values['homeAddress'],
        companyAddress: values['companyAddress'],
        role: 'customer',
        passwordConfirmation: values['confirmPassword'],
      );
      ref.read(authNotifierProvider.notifier).register(params);
    } else {
      AppToast.showError(
        context,
        message: "Please correct the errors in the form.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.unauthenticated &&
          previous?.status == AuthStatus.loading) {
        AppToast.showSuccess(context, message: "Registration successful!");
        context.router.replace(const LoginRoute());
      } else if (next.status == AuthStatus.error && next.failure != null) {
        if (next.failure is ValidationFailure) {
          setState(() {
            _validationErrors = (next.failure as ValidationFailure).errors;
          });
        } else {
          AppToast.showError(context, message: next.failure!.message);
        }
      }
    });

    final authState = ref.watch(authNotifierProvider);
    final theme = Theme.of(context);
    final l10n = context.l10n;

    return Scaffold(
      body: LoadingOverlay(
        isLoading: authState.status == AuthStatus.loading,
        child: ScreenWrapper(
          child: FormBuilder(
            key: _formKey,
            initialValue: _initialValues,
            child: ListView(
              children: [
                AppText(
                  l10n.registerBrandName,
                  style: AppTextStyle.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (_validationErrors != null && _validationErrors!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ErrorSummaryBox(errors: _validationErrors!),
                  ),
                _buildSectionTitle(l10n.registerTitle),
                AppTextField(
                  name: 'fullName',
                  label: l10n.registerLabelFullName,
                  placeHolder: l10n.registerPlaceholderFullName,
                  validator: AuthValidators.fullName,
                  type: AppTextFieldType.text,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'fullNameKana',
                  label: l10n.registerLabelFullNameKana,
                  placeHolder: l10n.registerPlaceholderFullNameKana,
                  validator: AuthValidators.fullNameKana,
                  type: AppTextFieldType.text,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'email',
                  label: l10n.registerLabelEmail,
                  placeHolder: l10n.registerPlaceholderEmail,
                  type: AppTextFieldType.email,
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'phoneNumber',
                  label: l10n.registerLabelPhoneNumber,
                  placeHolder: l10n.registerPlaceholderPhoneNumber,
                  type: AppTextFieldType.phone,
                  validator: AuthValidators.phoneNumber,
                ),
                const SizedBox(height: 16),
                AppDateTimePicker(
                  name: 'dateOfBirth',
                  label: l10n.registerLabelDateOfBirth,
                  inputType: InputType.date,
                  validator: AuthValidators.dateOfBirth,
                  lastDate: DateTime.now(),
                ),
                const SizedBox(height: 16),
                AppRadioGroup<UserGender>(
                  name: 'gender',
                  label: l10n.registerLabelGender,
                  validator: AuthValidators.gender,
                  options: [
                    FormBuilderFieldOption(
                      value: UserGender.male,
                      child: Text(l10n.registerGenderMale),
                    ),
                    FormBuilderFieldOption(
                      value: UserGender.female,
                      child: Text(l10n.registerGenderFemale),
                    ),
                    FormBuilderFieldOption(
                      value: UserGender.other,
                      child: Text(l10n.registerGenderOther),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'companyName',
                  label: l10n.registerLabelCompanyName,
                  placeHolder: l10n.registerPlaceholderCompanyName,
                  type: AppTextFieldType.text,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'department',
                  label: l10n.registerLabelDepartment,
                  placeHolder: l10n.registerPlaceholderDepartment,
                  type: AppTextFieldType.text,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'companyAddress',
                  label: l10n.registerLabelCompanyAddress,
                  placeHolder: l10n.registerPlaceholderCompanyAddress,
                  type: AppTextFieldType.multiline,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'homeAddress',
                  label: l10n.registerLabelHomeAddress,
                  placeHolder: l10n.registerPlaceholderHomeAddress,
                  type: AppTextFieldType.multiline,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'password',
                  label: l10n.registerLabelPassword,
                  placeHolder: l10n.registerPlaceholderPassword,
                  type: AppTextFieldType.password,
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'confirmPassword',
                  label: l10n.registerLabelConfirmPassword,
                  placeHolder: l10n.registerPlaceholderConfirmPassword,
                  type: AppTextFieldType.password,
                  validator: (value) {
                    final password =
                        _formKey.currentState?.fields['password']?.value;
                    return AuthValidators.confirmPassword(password ?? '')(
                      value,
                    );
                  },
                ),
                const SizedBox(height: 24),
                AppCheckbox(
                  name: 'terms',
                  title: RichText(
                    text: TextSpan(
                      style: theme.textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text:
                              '${l10n.registerTermsAgreement.split(" ").getRange(0, 4).join(" ")} ',
                        ),
                        TextSpan(
                          text: l10n.registerTermsOfServiceLink,
                          style: TextStyle(color: theme.colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.router.push(
                              const TermsOfServiceRoute(),
                            ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: l10n.registerPrivacyPolicyLink,
                          style: TextStyle(color: theme.colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () =>
                                context.router.push(const PrivacyPolicyRoute()),
                        ),
                      ],
                    ),
                  ),
                  validator: AuthValidators.termsAgreement,
                ),
                const SizedBox(height: 32),
                AppButton(
                  text: l10n.registerButton,
                  color: AppButtonColor.secondary,
                  isLoading: authState.status == AuthStatus.loading,
                  onPressed: () => _handleSubmit(ref),
                ),
                const SizedBox(height: 24),
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: [
                    AppText(l10n.registerAlreadyHaveAccount),
                    GestureDetector(
                      onTap: () => context.router.push(const LoginRoute()),
                      child: AppText(
                        l10n.registerSignInLink,
                        style: AppTextStyle.bodyMedium,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: AppText(title, style: AppTextStyle.headlineSmall),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/string_extensions.dart';
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
      );
      // ref.read(authNotifierProvider.notifier).register(params);

      AppToast.showSuccess(context, message: "Registration Submitted!");
      context.router.replace(LoginRoute());
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
      if (next.status == AuthStatus.error && next.failure != null) {
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
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'fullNameKana',
                  label: l10n.registerLabelFullNameKana,
                  placeHolder: l10n.registerPlaceholderFullNameKana,
                  validator: AuthValidators.fullNameKana,
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
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'department',
                  label: l10n.registerLabelDepartment,
                  placeHolder: l10n.registerPlaceholderDepartment,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'companyAddress',
                  label: l10n.registerLabelCompanyAddress,
                  placeHolder: l10n.registerPlaceholderCompanyAddress,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'homeAddress',
                  label: l10n.registerLabelHomeAddress,
                  placeHolder: l10n.registerPlaceholderHomeAddress,
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
                            ..onTap = () {
                              // TODO: Navigate to terms of service page
                            },
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: l10n.registerPrivacyPolicyLink,
                          style: TextStyle(color: theme.colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // TODO: Navigate to privacy policy page
                            },
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
                      onTap: () => context.router.replace(LoginRoute()),
                      child: AppText(
                        l10n.registerSignInLink,
                        style: AppTextStyle.body,
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
      child: AppText(title, style: AppTextStyle.headline),
    );
  }
}

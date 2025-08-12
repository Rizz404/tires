import 'package:auto_route/auto_route.dart';
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
class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
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
        password: values['password'],
        gender: values['gender'],
        dateOfBirth: values['dateOfBirth'],
        homeAddress: values['homeAddress'],
      );
      // ref.read(authNotifierProvider.notifier).profile(params);

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
                if (_validationErrors != null && _validationErrors!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ErrorSummaryBox(errors: _validationErrors!),
                  ),
                _buildSectionTitle(l10n.profileShowTitle),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppText(
                    context.l10n.profilePersonalInfoTitle,
                    style: AppTextStyle.titleLarge,
                  ),
                ),
                AppTextField(
                  name: 'fullName',
                  label: l10n.profileLabelFullName,
                  validator: AuthValidators.fullName,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'fullNameKana',
                  label: l10n.profileLabelFullNameKana,
                  validator: AuthValidators.fullNameKana,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'email',
                  label: l10n.profileLabelEmail,
                  type: AppTextFieldType.email,
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'phoneNumber',
                  label: l10n.profileLabelPhone,
                  validator: AuthValidators.phoneNumber,
                ),
                const SizedBox(height: 16),
                AppDateTimePicker(
                  name: 'dateOfBirth',
                  label: l10n.profileLabelDob,
                  inputType: InputType.date,
                  validator: AuthValidators.dateOfBirth,
                  lastDate: DateTime.now(),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'homeAddress',
                  label: l10n.profileLabelAddress,
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppText(
                    context.l10n.profileChangePasswordTitle,
                    style: AppTextStyle.titleLarge,
                  ),
                ),
                AppTextField(
                  name: 'password',
                  label: l10n.profileLabelNewPassword,
                  type: AppTextFieldType.password,
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'confirmPassword',
                  label: l10n.profileLabelConfirmPassword,
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
                AppButton(
                  text: l10n.profileButtonSaveChanges,
                  color: AppButtonColor.secondary,
                  isLoading: authState.status == AuthStatus.loading,
                  onPressed: () => _handleSubmit(ref),
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

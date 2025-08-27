import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/features/authentication/presentation/validations/auth_validators.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_mutation_state.dart';
import 'package:tires/features/user/presentation/providers/current_user_providers.dart';
import 'package:tires/l10n_generated/app_localizations.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_date_time_picker.dart';
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
  final _passwordFormKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;
  User? _currentUser;

  void _populateForm() {
    if (_currentUser != null && _formKey.currentState != null) {
      _formKey.currentState!.patchValue({
        'fullName': _currentUser!.fullName,
        'fullNameKana': _currentUser!.fullNameKana,
        'email': _currentUser!.email,
        'phoneNumber': _currentUser!.phoneNumber,
        'companyName': _currentUser!.companyName ?? '',
        'dateOfBirth': _currentUser!.dateOfBirth,
        'homeAddress': _currentUser!.homeAddress ?? '',
      });
    }
  }

  void _handleUpdateProfile(WidgetRef ref) {
    setState(() {
      _validationErrors = null;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;

      ref
          .read(currentUserMutationNotifierProvider.notifier)
          .updateCurrentUser(
            fullName: values['fullName'],
            fullNameKana: values['fullNameKana'],
            email: values['email'],
            phoneNumber: values['phoneNumber'],
            companyName: values['companyName']?.isEmpty == true
                ? null
                : values['companyName'],
            homeAddress: values['homeAddress']?.isEmpty == true
                ? null
                : values['homeAddress'],
            dateOfBirth: values['dateOfBirth'],
            gender: values['gender'],
          );
    } else {
      AppToast.showError(
        context,
        message: "Please correct the errors in the form.",
      );
    }
  }

  void _handleChangePassword(WidgetRef ref) {
    setState(() {
      _validationErrors = null;
    });

    if (_passwordFormKey.currentState?.saveAndValidate() ?? false) {
      final values = _passwordFormKey.currentState!.value;

      ref
          .read(currentUserMutationNotifierProvider.notifier)
          .updatePassword(
            currentPassword: values['currentPassword'] ?? '',
            newPassword: values['password'] ?? '',
            confirmPassword: values['confirmPassword'] ?? '',
          );
    } else {
      AppToast.showError(
        context,
        message: "Please correct the errors in the password form.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to user get state changes
    ref.listen(currentUserGetNotifierProvider, (previous, next) {
      if (next.status == CurrentUserGetStatus.success && next.user != null) {
        setState(() {
          _currentUser = next.user;
        });
        _populateForm();
      } else if (next.status == CurrentUserGetStatus.error &&
          next.errorMessage != null) {
        AppToast.showError(context, message: next.errorMessage!);
      }
    });

    // Listen to user mutation state changes
    ref.listen(currentUserMutationNotifierProvider, (previous, next) {
      if (next.status == CurrentUserMutationStatus.success) {
        if (next.updatedUser != null) {
          // Update local user data
          setState(() {
            _currentUser = next.updatedUser;
          });
          _populateForm();
        }
        AppToast.showSuccess(
          context,
          message: next.successMessage ?? 'Operation completed successfully',
        );
        // Clear password form after successful password change
        if (next.successMessage?.contains('Password') == true) {
          _passwordFormKey.currentState?.reset();
        }
      } else if (next.status == CurrentUserMutationStatus.error &&
          next.failure != null) {
        if (next.failure is ValidationFailure) {
          setState(() {
            _validationErrors = (next.failure as ValidationFailure).errors;
          });
        } else {
          AppToast.showError(context, message: next.failure!.message);
        }
      }
    });

    final userGetState = ref.watch(currentUserGetNotifierProvider);
    final userMutationState = ref.watch(currentUserMutationNotifierProvider);
    final l10n = context.l10n;

    final isLoading =
        userGetState.status == CurrentUserGetStatus.loading ||
        userMutationState.status == CurrentUserMutationStatus.loading;

    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        child: ScreenWrapper(
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (_validationErrors != null && _validationErrors!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ErrorSummaryBox(errors: _validationErrors!),
                  ),
                _buildSectionTitle(l10n.profileShowTitle),

                // Personal Info Section
                _buildPersonalInfoSection(l10n),
                const SizedBox(height: 48),

                // Password Change Section
                _buildPasswordChangeSection(l10n),
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

  Widget _buildPersonalInfoSection(L10n l10n) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: AppText(
              l10n.profilePersonalInfoTitle,
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
          AppTextField(name: 'companyName', label: l10n.profileLabelCompany),
          const SizedBox(height: 16),
          AppDateTimePicker(
            name: 'dateOfBirth',
            label: l10n.profileLabelDob,
            inputType: InputType.date,
            validator: AuthValidators.dateOfBirth,
            lastDate: DateTime.now(),
          ),
          const SizedBox(height: 16),
          AppTextField(name: 'homeAddress', label: l10n.profileLabelAddress),
          const SizedBox(height: 24),
          AppButton(
            text: l10n.profileButtonUpdateProfile,
            color: AppButtonColor.secondary,
            onPressed: () => _handleUpdateProfile(ref),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordChangeSection(dynamic l10n) {
    return FormBuilder(
      key: _passwordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: AppText(
              l10n.profileChangePasswordTitle,
              style: AppTextStyle.titleLarge,
            ),
          ),
          AppTextField(
            name: 'currentPassword',
            label: l10n.profileLabelCurrentPassword ?? 'Current Password',
            type: AppTextFieldType.password,
            validator: AuthValidators.password,
          ),
          const SizedBox(height: 16),
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
                  _passwordFormKey.currentState?.fields['password']?.value;
              return AuthValidators.confirmPassword(password ?? '')(value);
            },
          ),
          const SizedBox(height: 24),
          AppButton(
            text: l10n.profileButtonChangePassword ?? 'Change Password',
            color: AppButtonColor.primary,
            onPressed: () => _handleChangePassword(ref),
          ),
        ],
      ),
    );
  }
}

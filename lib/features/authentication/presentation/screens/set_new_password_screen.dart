import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/authentication/domain/usecases/set_new_password_usecase.dart';
import 'package:tires/features/authentication/presentation/providers/auth_providers.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';
import 'package:tires/features/authentication/presentation/validations/auth_validators.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class SetNewPasswordScreen extends ConsumerStatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  ConsumerState<SetNewPasswordScreen> createState() =>
      _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends ConsumerState<SetNewPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;

  void _handleSubmit(WidgetRef ref) {
    setState(() {
      _validationErrors = null;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final params = SetNewPasswordParams(
        currentPassword: values['currentPassword'],
        newPassword: values['newPassword'],
        confirmNewPassword: values['confirmNewPassword'],
      );

      ref.read(authNotifierProvider.notifier).setNewPassword(params);
    } else {
      // Todo: Add translation for formCorrectionMessage
      AppToast.showError(
        context,
        message: "Please correct the errors in the form.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.passwordResetSuccess) {
        // Todo: Add translation for passwordResetSuccessMessage
        AppToast.showSuccess(
          context,
          message:
              "Your password has been updated successfully. Please log in.",
        );
        // Navigate to Login, not Home, as the user is not authenticated yet.
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

    if (authState.status == AuthStatus.initial ||
        (authState.status == AuthStatus.loading && authState.user == null)) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (authState.status == AuthStatus.authenticated) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: LoadingOverlay(
        isLoading: authState.status == AuthStatus.loading,
        child: ScreenWrapper(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Todo: Add translation for setNewPasswordTitle
                const AppText(
                  'Set a New Password',
                  style: AppTextStyle.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Todo: Add translation for setNewPasswordSubtitle
                const AppText(
                  'Your new password must be different from previous used passwords.',
                  style: AppTextStyle.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (_validationErrors != null && _validationErrors!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ErrorSummaryBox(errors: _validationErrors!),
                  ),
                // Todo: Add translation for currentPasswordLabel
                // Todo: Add translation for currentPasswordPlaceholder
                AppTextField(
                  name: 'currentPassword',
                  label: 'Current Password',
                  placeHolder: 'Enter your current password',
                  type: AppTextFieldType.password,
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: 16),
                // Todo: Add translation for setNewPasswordLabel
                // Todo: Add translation for setNewPasswordPlaceholder
                AppTextField(
                  name: 'newPassword',
                  label: 'New Password',
                  placeHolder: 'Enter your new password',
                  type: AppTextFieldType.password,
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: 16),
                // Todo: Add translation for confirmNewPasswordLabel
                // Todo: Add translation for confirmNewPasswordPlaceholder
                AppTextField(
                  name: 'confirmNewPassword',
                  label: 'Confirm New Password',
                  placeHolder: 'Confirm your new password',
                  type: AppTextFieldType.password,
                  validator: (value) {
                    final newPassword =
                        _formKey.currentState?.fields['newPassword']?.value;
                    return AuthValidators.confirmPassword(newPassword ?? '')(
                      value,
                    );
                  },
                ),
                const SizedBox(height: 24),
                // Todo: Add translation for setNewPasswordButton
                AppButton(
                  text: 'Update Password',
                  color: AppButtonColor.secondary,
                  isLoading: authState.status == AuthStatus.loading,
                  onPressed: () => _handleSubmit(ref),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

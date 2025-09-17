import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/features/authentication/domain/usecases/forgot_password_usecase.dart';
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
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;

  void _handleSubmit(WidgetRef ref) {
    final l10n = context.l10n;
    setState(() {
      _validationErrors = null;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final params = ForgotPasswordParams(email: values['email']);

      ref.read(authNotifierProvider.notifier).forgotPassword(params);
    } else {
      AppToast.showError(context, message: l10n.forgotPasswordFormError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    ref.listen(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.passwordResetEmailSent) {
        AppToast.showSuccess(
          context,
          message: l10n.forgotPasswordSuccessMessage,
        );
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
                AppText(
                  l10n.forgotPasswordTitle,
                  style: AppTextStyle.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                AppText(
                  l10n.forgotPasswordSubtitle,
                  style: AppTextStyle.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                if (_validationErrors != null && _validationErrors!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ErrorSummaryBox(errors: _validationErrors!),
                  ),
                AppTextField(
                  name: 'email',
                  label: l10n.forgotPasswordEmailLabel,
                  placeHolder: l10n.forgotPasswordEmailPlaceholder,
                  type: AppTextFieldType.email,
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: 24),
                AppButton(
                  text: l10n.forgotPasswordButton,
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
                    AppText(l10n.forgotPasswordRemembered),
                    GestureDetector(
                      onTap: () => context.router.pop(),
                      child: AppText(
                        l10n.forgotPasswordBackToLogin,
                        style: AppTextStyle.bodyMedium,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

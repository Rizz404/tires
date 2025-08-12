import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/authentication/domain/usecases/login_usecase.dart';
import 'package:tires/features/authentication/presentation/providers/auth_providers.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';
import 'package:tires/features/authentication/presentation/validations/auth_validators.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_checkbox.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;

  void _handleSubmit(WidgetRef ref) {
    setState(() {
      _validationErrors = null;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final params = LoginParams(
        email: values['email'],
        password: values['password'],
      );
      // ref.read(authNotifierProvider.notifier).login(params);

      AppToast.showSuccess(context, message: "Login Submitted!");
      context.router.replace(const HomeRoute()); // Navigate to a home route
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  l10n.loginTitle,
                  style: AppTextStyle.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                if (_validationErrors != null && _validationErrors!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ErrorSummaryBox(errors: _validationErrors!),
                  ),
                AppTextField(
                  name: 'email',
                  label: l10n.loginEmailLabel,
                  placeHolder: l10n.loginEmailPlaceholder,
                  type: AppTextFieldType.email,
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  name: 'password',
                  label: l10n.loginPasswordLabel,
                  placeHolder: l10n.loginPasswordPlaceholder,
                  type: AppTextFieldType.password,
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: 8),
                AppCheckbox(
                  name: 'remember',
                  title: AppText(l10n.loginRememberMe),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // TODO: Navigate to forgot password screen
                      },
                      child: AppText(
                        l10n.loginForgotPassword,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                AppButton(
                  text: l10n.loginButton,
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
                    AppText(l10n.loginNoAccountPrompt),
                    GestureDetector(
                      onTap: () => context.router.replace(RegisterRoute()),
                      child: AppText(
                        l10n.loginSignupLink,
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

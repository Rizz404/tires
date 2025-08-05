import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/network/api_error_response.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/authentication/domain/usecases/register_usecase.dart';
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
class RegisterScreen extends ConsumerStatefulWidget {
  RegisterScreen({super.key});

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
        username: values['username'],
        email: values['email'],
        password: values['password'],
      );
      ref.read(authNotifierProvider.notifier).register(params);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authNotifierProvider, (previous, next) {
      if (next.status == AuthStatus.error && next.failure != null) {
        if (next.failure is ValidationError) {
          setState(() {
            _validationErrors = (next.failure as ValidationFailure).errors;
          });
        } else {
          AppToast.showError(context, message: next.failure!.message);
        }
      } else {
        AppToast.showSuccess(context, message: "Register Successful!");
        context.router.pushAll([LoginRoute()]);
      }
    });

    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: LoadingOverlay(
        isLoading: authState.status == AuthStatus.loading,
        child: ScreenWrapper(
          child: FormBuilder(
            key: _formKey,
            child: ListView(
              children: [
                const AppText("Welcome!", style: AppTextStyle.titleLarge),
                const SizedBox(height: 8),

                const AppText(
                  "Please sign up to continue",
                  style: AppTextStyle.body,
                ),
                const SizedBox(height: 24),

                if (_validationErrors != null && _validationErrors!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ErrorSummaryBox(errors: _validationErrors!),
                  ),

                AppTextField(
                  name: 'username',
                  label: 'Username',
                  type: AppTextFieldType.text,
                  validator: AuthValidators.username,
                ),
                const SizedBox(height: 24),

                AppTextField(
                  name: 'email',
                  label: 'Email',
                  type: AppTextFieldType.email,
                  validator: AuthValidators.email,
                ),
                const SizedBox(height: 24),

                AppTextField(
                  name: 'password',
                  label: 'Password',
                  type: AppTextFieldType.password,
                  validator: AuthValidators.password,
                ),
                const SizedBox(height: 24),

                AppTextField(
                  name: 'confirmPassword',
                  label: 'Confirm Password',
                  type: AppTextFieldType.password,
                  validator: (value) {
                    // * Umazing
                    final password =
                        _formKey.currentState?.fields['password']?.value;
                    return AuthValidators.confirmPassword(password ?? '')(
                      value,
                    );
                  },
                ),
                const SizedBox(height: 48),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppText("Already have an account? "),
                    GestureDetector(
                      child: const AppText("login"),
                      onTap: () {
                        context.router.push(LoginRoute());
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                AppButton(
                  text: "Register",
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

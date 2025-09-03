import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/features/inquiry/presentation/providers/inquiry_providers.dart';
import 'package:tires/features/inquiry/presentation/providers/inquiry_mutation_state.dart';
import 'package:tires/features/user/domain/entities/user.dart';
import 'package:tires/features/user/presentation/providers/current_user_get_state.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';
import 'package:tires/shared/presentation/widgets/debug_section.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

@RoutePage()
class InquiryScreen extends ConsumerStatefulWidget {
  const InquiryScreen({super.key});

  @override
  ConsumerState<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends ConsumerState<InquiryScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;
  User? _currentUser;
  bool _isSubmitting = false; // Add flag to prevent multiple submissions

  void _populateForm() {
    if (_currentUser != null && _formKey.currentState != null) {
      _formKey.currentState!.patchValue({
        'name': _currentUser!.fullName,
        'email': _currentUser!.email,
        'phoneNumber': _currentUser!.phoneNumber,
      });
    }
  }

  void _handleSubmit(WidgetRef ref) {
    if (_isSubmitting) return; // Prevent multiple submissions

    setState(() {
      _validationErrors = null;
      _isSubmitting = true;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;

      ref
          .read(inquiryMutationNotifierProvider.notifier)
          .createInquiry(
            name: values['name'] as String,
            email: values['email'] as String,
            phone: values['phoneNumber'] as String?,
            subject: values['subject'] as String,
            message: values['message'] as String,
          );
    } else {
      setState(() {
        _isSubmitting = false;
      });
      AppToast.showError(context, message: context.l10n.inquiryErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the current user state and populate form immediately if user exists
    final userGetState = ref.watch(inquiryUserGetNotifierProvider);

    // Check if user data is available and form needs to be populated
    if (userGetState.status == CurrentUserGetStatus.success &&
        userGetState.user != null &&
        _currentUser != userGetState.user) {
      // Update current user and populate form
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _currentUser = userGetState.user;
        });
        _populateForm();
      });
    }

    // Listen to user get state changes
    ref.listen(inquiryUserGetNotifierProvider, (previous, next) {
      if (next.status == CurrentUserGetStatus.success && next.user != null) {
        setState(() {
          _currentUser = next.user;
        });
        _populateForm();
      } else if (next.status == CurrentUserGetStatus.error &&
          next.errorMessage != null) {
        debugPrint(next.errorMessage);
        AppToast.showError(context, message: next.errorMessage!);
      }
    });

    // Listen to inquiry mutation state changes
    ref.listen(inquiryMutationNotifierProvider, (previous, next) {
      // Reset submission flag when operation completes
      if (next.status != InquiryMutationStatus.loading) {
        setState(() {
          _isSubmitting = false;
        });
      }

      if (next.status == InquiryMutationStatus.success) {
        AppToast.showSuccess(
          context,
          message: next.successMessage ?? context.l10n.inquirySuccessMessage,
        );
        // Only clear subject and message fields, keep user data
        _formKey.currentState?.patchValue({'subject': '', 'message': ''});
        FocusScope.of(context).unfocus();
        // Clear success message after showing toast
        ref.read(inquiryMutationNotifierProvider.notifier).clearSuccess();
      } else if (next.status == InquiryMutationStatus.error &&
          next.failure != null) {
        if (next.failure is ValidationFailure) {
          setState(() {
            _validationErrors = (next.failure as ValidationFailure).errors;
          });
        } else {
          AppToast.showError(
            context,
            message: next.failure!.message ?? context.l10n.inquiryErrorMessage,
          );
        }
      }
    });

    final inquiryMutationState = ref.watch(inquiryMutationNotifierProvider);
    final l10n = context.l10n;

    final isLoading =
        userGetState.status == CurrentUserGetStatus.loading ||
        inquiryMutationState.status == InquiryMutationStatus.loading;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarInquiry)),
      endDrawer: const UserEndDrawer(),
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
                _buildSectionTitle(l10n.inquiryFormTitle),
                _buildInquiryForm(l10n),
                const SizedBox(height: 24),
                // Simple debug example
                if (true) // Change to kDebugMode for production
                  // _buildSimpleDebugSection(),
                  const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInquiryForm(dynamic l10n) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            name: 'name',
            label: l10n.inquiryFormName,
            placeHolder: l10n.inquiryPlaceholderName,
            validator: FormBuilderValidators.required(),
          ),
          const SizedBox(height: 16),
          AppTextField(
            name: 'email',
            label: l10n.inquiryFormEmail,
            placeHolder: l10n.inquiryPlaceholderEmail,
            type: AppTextFieldType.email,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.email(),
            ]),
          ),
          const SizedBox(height: 16),
          AppTextField(
            name: 'phoneNumber',
            label: l10n.inquiryFormPhone,
            placeHolder: l10n.inquiryPlaceholderPhone,
            // Phone is optional, so no validator
          ),
          const SizedBox(height: 16),
          AppTextField(
            name: 'subject',
            label: l10n.inquiryFormSubject,
            validator: FormBuilderValidators.required(),
          ),
          const SizedBox(height: 16),
          AppTextField(
            name: 'message',
            label: l10n.inquiryFormInquiryContent,
            placeHolder: l10n.inquiryPlaceholderMessage,
            maxLines: 6,
            validator: FormBuilderValidators.required(),
          ),
          const SizedBox(height: 24),
          AppButton(
            text: l10n.inquiryFormSubmitButton,
            onPressed: _isSubmitting ? null : () => _handleSubmit(ref),
            isLoading: _isSubmitting,
          ),
        ],
      ),
    );
  }

  // Widget _buildSimpleDebugSection() {
  //   return DebugSection(
  //     title: '📝 Inquiry Form Debug',
  //     actions: [
  //       DebugAction.inspect(
  //         label: 'Inspect Form Values',
  //         onPressed: () {
  //           final formValues = _formKey.currentState?.value ?? {};
  //           DebugHelper.logMapDetails(
  //             Map<String, dynamic>.from(formValues),
  //             title: 'Current Form Values',
  //           );
  //         },
  //       ),
  //       DebugAction.inspect(
  //         label: 'Inspect Inquiry State',
  //         onPressed: () {
  //           final state = ref.read(inquiryMutationNotifierProvider);
  //           print('\n=== Inquiry Mutation State Debug ===');
  //           print('Status: ${state.status}');
  //           print('Success Message: ${state.successMessage}');
  //           print('Failure: ${state.failure}');
  //           print('Created Contact: ${state.createdContact}');
  //           print('=== End Debug ===\n');
  //         },
  //       ),
  //       DebugAction.clear(
  //         label: 'Clear Form',
  //         onPressed: () {
  //           _formKey.currentState?.reset();
  //           setState(() {
  //             _validationErrors = null;
  //           });
  //           ref.read(inquiryMutationNotifierProvider.notifier).clearState();
  //         },
  //       ),
  //       DebugAction.viewLogs(
  //         label: 'Show Debug Info',
  //         context: context,
  //         message: 'Form and state debug information logged to console',
  //       ),
  //     ],
  //   );
  // }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AppText(
        title,
        style: AppTextStyle.headlineSmall,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

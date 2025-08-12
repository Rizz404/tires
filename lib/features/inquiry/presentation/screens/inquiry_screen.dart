import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:tires/core/error/failure.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/features/authentication/presentation/providers/auth_state.dart';
import 'package:tires/shared/presentation/utils/app_toast.dart';
import 'package:tires/shared/presentation/widgets/app_button.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';
import 'package:tires/shared/presentation/widgets/error_summary_box.dart';
import 'package:tires/shared/presentation/widgets/loading_overlay.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';
import 'package:tires/shared/presentation/widgets/user_end_drawer.dart';

@RoutePage()
class InquiryScreen extends ConsumerStatefulWidget {
  const InquiryScreen({super.key});

  @override
  ConsumerState<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends ConsumerState<InquiryScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<DomainValidationError>? _validationErrors;

  void _handleSubmit(WidgetRef ref) {
    setState(() {
      _validationErrors = null;
    });

    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final values = _formKey.currentState!.value;
      final params = {
        'name': values['name'],
        'email': values['email'],
        'phoneNumber': values['phoneNumber'],
        'subject': values['subject'],
        'message': values['message'],
      };

      // Simulasi sukses
      AppToast.showSuccess(
        context,
        message: context.l10n.inquirySuccessMessage,
      );
      _formKey.currentState?.reset();
      FocusScope.of(context).unfocus(); // Tutup keyboard
    } else {
      AppToast.showError(context, message: context.l10n.inquiryErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = AuthState(); // Placeholder
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.inquiryFormTitle)),
      endDrawer: const UserEndDrawer(),
      body: LoadingOverlay(
        isLoading: authState.status == AuthStatus.loading,
        child: ScreenWrapper(
          child: FormBuilder(
            key: _formKey,
            child: ListView(
              children: [
                // _buildOfficeInfo(context),
                // const SizedBox(height: 32),
                _buildSectionTitle(l10n.inquiryFormTitle),
                if (_validationErrors != null && _validationErrors!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: ErrorSummaryBox(errors: _validationErrors!),
                  ),
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
                  onPressed: () => _handleSubmit(ref),
                  isLoading: authState.status == AuthStatus.loading,
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
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AppText(
        title,
        style: AppTextStyle.headlineSmall,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Widget _buildOfficeInfo(BuildContext context) {
  //   final l10n = context.l10n;
  //   return Card(
  //     elevation: 2,
  //     shadowColor: context.theme.shadowColor.withOpacity(0.05),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           AppText(
  //             l10n.inquirySidebarOpeningHours,
  //             style: AppTextStyle.titleMedium,
  //             fontWeight: FontWeight.bold,
  //           ),
  //           const SizedBox(height: 8),
  //           _buildOpeningHourRow(l10n.inquiryDayMonday, '09:00 - 18:00'),
  //           _buildOpeningHourRow(l10n.inquiryDayTuesday, '09:00 - 18:00'),
  //           _buildOpeningHourRow(l10n.inquiryDayWednesday, '09:00 - 18:00'),
  //           _buildOpeningHourRow(l10n.inquiryDayThursday, '09:00 - 18:00'),
  //           _buildOpeningHourRow(l10n.inquiryDayFriday, '09:00 - 18:00'),
  //           _buildOpeningHourRow(l10n.inquiryDaySaturday, '09:00 - 17:00'),
  //           _buildOpeningHourRow(
  //             l10n.inquiryDaySunday,
  //             l10n.inquirySidebarClosed,
  //             isClosed: true,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildOpeningHourRow(
  //   String day,
  //   String hours, {
  //   bool isClosed = false,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 4),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         AppText(day, style: AppTextStyle.bodyMedium),
  //         AppText(
  //           hours,
  //           style: AppTextStyle.bodyMedium,
  //           fontWeight: isClosed ? FontWeight.bold : FontWeight.normal,
  //           color: isClosed ? context.colorScheme.error : null,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
